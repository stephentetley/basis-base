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


    /// Make an alias so clients reference only the Basis mod
    pub type alias BufferedReader[r: Region] = Interop.IO.BufferedReader[r]
}


mod Basis.IO.BufferedReader {

    use Basis.IO.BufferedReader
    use Basis.IO.Reader



    pub def toReader(rd: BufferedReader[r]): Reader[r] = 
        Interop.IO.SubReader.toReader(rd)


    pub def newWithReader(rc: Region[r1], rd: Reader[r]): BufferedReader[r1] \ {r, r1} =
        Interop.IO.BufferedReader.newWithReader(rc, rd)



    pub def close!(br: BufferedReader[r]): Result[String, Unit] \ r =
        Interop.IO.BufferedReader.close!(br)

    pub def linesIterator!(rc: Region[r1], br: BufferedReader[r]): Result[String, Iterator[String, r + r1, r1]] =
        Interop.IO.BufferedReader.lines!(rc, br) |> Result.map(Interop.Util.Stream.Stream.iterator(rc))

    pub def read!(br: BufferedReader[r]): Result[String, Option[Int32]] \ r = 
        Interop.IO.BufferedReader.read!(br)

    /// Note - this is an example of using the methods of the super class in the current class.
    /// Because `Reader` is an abstract class in should probably not be expose in the basis API.
    pub def skip!(n: Int64, br: BufferedReader[r]): Result[String, Int64] \ r = 
        toReader(br) |> Interop.IO.Reader.skip!(n)
    

}
