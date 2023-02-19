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


namespace Basis/IO {


    pub type alias FileInputStream[r: Region] = Interop/IO.FileInputStream[r]

}

namespace Basis/IO/FileInputStream {

    use Basis/IO.FileInputStream
    use Basis/IO.InputStream
    use Basis/NIO/File.Path

    pub def toInputStream(s: FileInputStream[r]): InputStream[r] =
        Interop/IO/SubInputStream.toInputStream(s)

    pub def fromInputStream(s: InputStream[r]): FileInputStream[r] =
        Interop/IO/SubInputStream.fromInputStream(s)

    pub def newWithPath(rc: Region[r], path: Path): Result[String, FileInputStream[r]] \ {IO, Write(r)} = 
        Interop/NIO/File/Path.toString(path) |> Interop/IO/FileInputStream.newWithPath(rc)

}
