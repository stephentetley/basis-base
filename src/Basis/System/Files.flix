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

    use Basis/System.FilePath;
    use Basis/System.FilePath.{FilePath};
    use Basis/System/StandardOpenOption.StandardOpenOption;
    use Basis/Text.Charset;
    use Basis/Text.Charset.{Charset};

    /// UTF_8
    pub def readString(path: FilePath): Result[String, String] \ IO = 
        let FilePath(path1) = path;
        Interop/NIO/File/Files.readString(path1)

    pub def readStringWithCharset(path: FilePath, cs: Charset): Result[String, String] \ IO = 
        let FilePath(path1) = path;
        let Charset(cs1) = cs;
        Interop/NIO/File/Files.readStringWithCharset(path1, cs1)

    // UTF_8
    pub def writeString(path: FilePath, opts: List[StandardOpenOption], s: String): Result[Unit, String] \ IO = region r {
        let FilePath(path1) = path;
        let ws = Interop/Flix/WrappedRegion.mkStringWithRegion(r, s);
        let opts1 = List.map(Basis/System/StandardOpenOption.marshallStandardOpenOption, opts);
        Interop/NIO/File/Files.writeString(path1, ws, opts1) |> Result.map(_ -> ())
    }

    // UTF_8
    pub def writeStringWithCharset(path: FilePath, cs: Charset, opts: List[StandardOpenOption], s: String): Result[Unit, String] \ IO = region r {
        let FilePath(path1) = path;
        let ws = Interop/Flix/WrappedRegion.mkStringWithRegion(r, s);
        let Charset(cs1) = cs;
        let opts1 = List.map(Basis/System/StandardOpenOption.marshallStandardOpenOption, opts);
        Interop/NIO/File/Files.writeStringWithCharset(path1, ws, cs1, opts1) |> Result.map(_ -> ())
    }

}
