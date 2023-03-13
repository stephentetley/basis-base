/*
 * Copyright 2020 Stephen Tetley
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


namespace Basis/Lang {


    /// Make an alias so clients reference only the Basis namespace
    pub type alias CharSequence[r: Region] = Interop/Lang.CharSequence[r]
}


namespace Basis/Lang/CharSequence {

    use Basis/Lang.CharSequence;
    use Interop/Lang.CharSequence.{CharSequence};

    /// TODO - to remove? CharSequence is an interface - should we just deal 
    /// with concrete implementations - String, StringBuilder... ?

    pub def fromString(_: Region[r], s: String): CharSequence[r] \ Write(r) = 
        unchecked_cast(CharSequence(unchecked_cast(s as ##java.lang.CharSequence)) as _ \ Write(r))

    pub def fromStringBuilder(sb: StringBuilder[r]): CharSequence[r] \ Write(r) = 
        let StringBuilder(sb1) = sb;
        unchecked_cast(CharSequence(unchecked_cast(sb1 as ##java.lang.CharSequence)) as _ \ Write(r))


}
