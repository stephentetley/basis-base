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


    /// FilterInputStream - has no public constructors, does this imply it should not be exposed by Basis?
    pub type alias FilterInputStream[r: Region] = Interop.IO.FilterInputStream[r]

}

mod Basis.IO.FilterInputStream {

    use Basis.IO.FilterInputStream;
    use Basis.IO.InputStream;

    pub def toInputStream(s: FilterInputStream[r]): InputStream[r] =
        Interop.IO.SubInputStream.toInputStream(s)

    pub def fromInputStream(s: InputStream[r]): FilterInputStream[r] =
        Interop.IO.SubInputStream.fromInputStream(s)
}        