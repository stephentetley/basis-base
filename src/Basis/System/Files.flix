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


namespace Basis/System/Files {

    use Basis/System.Path;
    use Basis/System/LinkOption.LinkOption;
    use Basis/System/StandardOpenOption.StandardOpenOption;
    use Basis/NIO/Charset.Charset;


    pub def exists(path: Path, opts: List[LinkOption]): Result[Bool, String] \ IO = 
        let opts1 = List.map(Basis/System/LinkOption.marshallLinkOption, opts);
        Interop/NIO/File/Files.exists(path, opts1)

    /// UTF_8
    pub def readStringUtf8(path: Path): Result[String, String] \ IO = 
        Interop/NIO/File/Files.readStringUtf8(path)

    pub def readStringWithCharset(path: Path, cs: Charset): Result[String, String] \ IO = 
        Interop/NIO/File/Files.readString(path, cs)

    // UTF_8
    pub def writeStringUtf8!(path: Path, opts: List[StandardOpenOption], s: String): Result[Unit, String] \ IO = region r {
        let ws = Interop/Flix/WrappedRegion.wrapStringWithRegion(r, s);
        let opts1 = List.map(Basis/System/StandardOpenOption.marshallStandardOpenOption, opts);
        Interop/NIO/File/Files.writeStringUtf8!(path, ws, opts1) |> Result.map(_ -> ())
    }

    // 
    pub def writeStringWithCharset!(path: Path, cs: Charset, opts: List[StandardOpenOption], s: String): Result[Unit, String] \ IO = region r {
        let ws = Interop/Flix/WrappedRegion.wrapStringWithRegion(r, s);
        let opts1 = List.map(Basis/System/StandardOpenOption.marshallStandardOpenOption, opts);
        Interop/NIO/File/Files.writeString!(path, ws, cs, opts1) |> Result.map(_ -> ())
    }

}
