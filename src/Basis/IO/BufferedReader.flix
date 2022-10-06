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


    /// Make an alias so clients reference only the Basis namespace
    pub type alias BufferedReader[r: Region] = Interop/IO.BufferedReader[r]
}


namespace Basis/IO/BufferedReader {

    use Basis/IO.BufferedReader;
    use Basis/IO.InputStreamReader;
    use Basis/IO.Reader;



    pub def toReader(rd: BufferedReader[r]): Reader[r] = 
        Interop/IO/SubReader.toReader(rd)


    pub def newWithReader(rd: Reader[r]): BufferedReader[r] \ Write(r) = 
        Interop/IO/BufferedReader.newWithReader(rd)



    pub def close!(br: BufferedReader[r]): Result[Unit, String] \ Write(r) =
        Interop/IO/BufferedReader.close!(br)

    pub def linesIterator!(br: BufferedReader[r]): Result[Iterator[String, r], String] \ Read(r) =
        Interop/IO/BufferedReader.lines!(br) |> Result.map(Interop/Util/Stream/Stream.iterator)

    pub def read!(br: BufferedReader[r]): Result[Option[Int32], String] \ Read(r) = 
        Interop/IO/BufferedReader.read!(br)

    pub def skip!(n: Int64, br: BufferedReader[r]): Result[Int64, String] \ Read(r) = 
        Interop/IO/Reader.skip!(n, br)


}
