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


namespace Basis/NIO/File/Files {

    use Basis/NIO/Charset.Charset;
    use Basis/NIO/File.Path;
    use Basis/NIO/File/LinkOption.LinkOption;
    use Basis/NIO/File.OpenOption;
    use Basis/IO.InputStream;
    use Basis/Lang.CharSequence;


    pub def exists(path: Path, opts: List[LinkOption]): Result[Bool, String] \ IO = 
        let opts1 = List.map(Basis/NIO/File/LinkOption.marshallLinkOption, opts);
        Interop/NIO/File/Files.exists(path, opts1)


    /// TODO - should be able to take LinkOption.NofollowLinks
    pub def newInputStream(r: Region[r], path: Path, opts: List[OpenOption]): Result[InputStream[r], String] \ IO = 
        Interop/NIO/File/Files.newInputStream(r, path, opts)


    /// UTF_8
    pub def readStringUtf8(path: Path): Result[String, String] \ IO = 
        Interop/NIO/File/Files.readStringUtf8(path)

    pub def readStringWithCharset(path: Path, cs: Charset): Result[String, String] \ IO = 
        Interop/NIO/File/Files.readString(path, cs)

    // UTF_8
    pub def writeStringUtf8!(path: Path, opts: List[OpenOption], s: String): Result[Unit, String] \ IO = region r {
        let s1 = Basis/Lang/CharSequence.fromString(r, s);
        Interop/NIO/File/Files.writeStringUtf8!(path, s1, opts) |> Result.map(_ -> ())
    }

    // 
    pub def writeStringWithCharset!(path: Path, cs: Charset, opts: List[OpenOption], s: String): Result[Unit, String] \ IO = region r {
        let s1 = Basis/Lang/CharSequence.fromString(r, s);
        Interop/NIO/File/Files.writeString!(path, s1, cs, opts) |> Result.map(_ -> ())
    }
    
    // UTF_8
    pub def writeStringBuilderUtf8!(path: Path, opts: List[OpenOption], sb: StringBuilder[r]): Result[Unit, String] \ {IO, Read(r)} =
        let sb1 = Basis/Lang/CharSequence.fromStringBuilder(sb);
        Interop/NIO/File/Files.writeStringUtf8!(path, sb1, opts) |> Result.map(_ -> ())
    

    // 
    pub def writeStringBuilderWithCharset!(path: Path, cs: Charset, opts: List[OpenOption], sb: StringBuilder[r]): Result[Unit, String] \ {IO, Read(r)} = 
        let sb1 = Basis/Lang/CharSequence.fromStringBuilder(sb);
        Interop/NIO/File/Files.writeString!(path, sb1, cs, opts) |> Result.map(_ -> ())

}
