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


    
    pub type alias InputStreamReader[r: Region] = Interop/IO.InputStreamReader[r]

}

namespace Basis/IO/InputStreamReader {

    use Basis/IO.InputStreamReader
    use Basis/IO.InputStream
    use Basis/IO.Reader
    use Basis/NIO/Charset.Charset

    /// Provide a `to` function to upcast.

    pub def toReader(rc: Region[r1], rd: InputStreamReader[r]): Reader[r1] = 
        Interop/IO/SubReader.toReader(rc, rd)

    pub def newInputStreamReader(rc: Region[r1], ins: InputStream[r], cs: Charset): InputStreamReader[r1] \ { Read(r), Write(r1) } = 
        Interop/IO/InputStreamReader.newInputStreamReader(rc, ins, cs)


    pub def getEncoding(rd: InputStreamReader[r]): String \ Read(r) = 
        Interop/IO/InputStreamReader.getEncoding(rd)

    pub def close!(rd: InputStreamReader[r]): Result[String, Unit] \ Write(r) = 
        Interop/IO/InputStreamReader.close!(rd)

}

