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

    use Basis/IO.BufferedReader
    use Basis/IO.Reader



    pub def toReader(rc: Region[r1], rd: BufferedReader[r]): Reader[r1] = 
        Interop/IO/SubReader.toReader(rc, rd)


    // pub def newWithReader(rc: Region[r1], rd: Reader[r]): BufferedReader[r1] \ { Read(r), Write(r1) } =
    //     Interop/IO/BufferedReader.newWithReader(rc, rd)



    pub def close!(br: BufferedReader[r]): Result[String, Unit] \ Write(r) =
        Interop/IO/BufferedReader.close!(br)

    // pub def linesIterator!(rh: Region[rh], br: BufferedReader[r]): Result[String, Iterator[String, rh, rh]] \ { Read(r), Write(rh) } =
    //     Interop/IO/BufferedReader.lines!(br) |> Result.map(Interop/Util/Stream/Stream.iterator(rh))

    pub def read!(br: BufferedReader[r]): Result[String, Option[Int32]] \ Read(r) = 
        Interop/IO/BufferedReader.read!(br)

    /// TODO - obviously we don't want to pass a region about just to cast BufferedReader to Reader...
    pub def skip!(rc: Region[r1], n: Int64, br: BufferedReader[r]): Result[String, Int64] \ Read(r1) = 
        toReader(rc, br) |> Interop/IO/Reader.skip!(n)
    

}
