/*
 * Copyright 2022 Stephen Tetley
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


mod Basis.IO {


    
    pub type alias InputStreamReader[r: Region] = Interop.IO.InputStreamReader[r]

}

mod Basis.IO.InputStreamReader {

    use Basis.IO.InputStreamReader
    use Basis.IO.InputStream
    use Basis.IO.Reader
    use Basis.NIO.Charset.Charset

    /// Provide a `to` function to upcast.
    /// TODO should this be in the API?  
    pub def toReader(rd: InputStreamReader[r]): Reader[r] = 
        Interop.IO.SubReader.toReader(rd)

    pub def newInputStreamReader(rc: Region[r1], ins: InputStream[r], cs: Charset): InputStreamReader[r1] \ {r, r1} = 
        Interop.IO.InputStreamReader.newInputStreamReader(rc, ins, cs)


    pub def getEncoding(rd: InputStreamReader[r]): String \ r = 
        Interop.IO.InputStreamReader.getEncoding(rd)

    pub def close!(rd: InputStreamReader[r]): Result[String, Unit] \ r = 
        Interop.IO.InputStreamReader.close!(rd)

}

