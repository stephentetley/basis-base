/*
 * Copyright 2020 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


mod Basis.Lang {


    /// Make an alias so clients reference only the Basis mod
    pub type alias Process[r: Region] = Interop.Lang.Process[r]

}


mod Basis.Lang.Process {


    use Basis.Lang.Process
    use Basis.Lang.ProcessBuilder
    use Basis.Lang.ProcessBuilder.{ProcessBuilder}


    pub def processBuilder(cmd: String, args: List[String]): ProcessBuilder[r, ka, r, Unit] =
        Basis.Lang.ProcessBuilder.command!(cmd, args)


    pub def waitFor!(p: Process[r]): Result[String, Int32] \ {IO, r} =
        Interop.Lang.Process.waitFor!(p)


    pub def getInput(cs: Charset, p: Process[r]): Result[String, String] \ IO = 
        region rc {
            forM (strm <- Ok(Interop.Lang.Process.getInputStream(rc, p));
                    bytes <- Interop.IO.InputStream.readAllBytes(rc, strm))
            yield Interop.Lang.StringZ.fromArrayWithCharset(cs, bytes)
        }

    pub def getError(cs: Charset, p: Process[r]): Result[String, String] \ IO = region rc {
        forM (strm <- Ok(Interop.Lang.Process.getErrorStream(rc, p));
                bytes <- Interop.IO.InputStream.readAllBytes(rc, strm))
        yield Interop.Lang.StringZ.fromArrayWithCharset(cs, bytes)
    }


    pub type alias ProcessArgs =
        { cmd = String
        , args = List[String]
        , charset = Charset
        }

    /// Return with an Exit Code
    pub def processWithExitCode(args: ProcessArgs): Result[String, {exitCode = Int32, processResponse = String}] \ IO =
        region r1 {
            forM (pb        <- Ok(processBuilder(args.cmd, args.args));
                    proc        <- Basis.Lang.ProcessBuilder.start(r1, pb);
                    respGood    <- getInput(args.charset, proc);
                    respBad     <- getError(args.charset, proc);
                    code        <- waitFor!(proc)
            ) yield {exitCode = code, processResponse = if (code == 0) respGood else respBad}
        }


    pub def process(args: ProcessArgs): Result[String, {processResponse = String}] \ IO =
        region r1 {
            forM (pb        <- Ok(processBuilder(args.cmd, args.args));
                    proc        <- Basis.Lang.ProcessBuilder.start(r1, pb);
                    respGood    <- getInput(args.charset, proc);
                    respBad     <- getError(args.charset, proc);
                    code        <- waitFor!(proc);
                    ans         <- if (code == 0) Ok({processResponse = respGood}) else Err(respBad)
            ) yield  ans                
        }


}
