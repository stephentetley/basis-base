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

namespace Basis/Text {
    
    ///
    /// Represents a Collator.
    ///
    pub type alias MutCollator[r: Region] = Interop/Text.Collator[r]
    
    /// Design Note - ideally Collator would be immutable (possibly with a 
    /// builder to initially configure it)

}

namespace Basis/Text/MutCollator {

    use Basis/Text.MutCollator;
    use Basis/Text.Collator;
    use Basis/Text.Collator.{Collator};
    use Basis/Text/Collator.DecompositionMode;
    use Basis/Text/Collator.CollatorStrength;

    use Basis/Util.Locale;

    ///
    /// TODO - this is wrong, we can only `thaw` an immutable Collator to a mutable one.
    /// `freeze` does not prevent the underlying MutCollator being changed elsewhere which
    /// will change the "immutable" Collator.
    /// Uses a Collator to be accurate with the locale of the JVM.
    ///
    pub def freeze(col: MutCollator[r]): Collator =
        Interop/Text/Collator.getHH(col) |> Collator


    ///
    /// Uses a Collator to be accurate with the locale of the JVM.
    ///
    pub def getInstance(r: Region[r]): MutCollator[r] \ {Write(r), IO} =
        Interop/Text/Collator.getInstance(r)


    pub def getInstanceWithLocale(r: Region[r], loc: Locale): MutCollator[r] \ Write(r) =
        Interop/Text/Collator.getInstanceWithLocale(r, loc)


    pub def setDecomposition!(mode: DecompositionMode, col: MutCollator[r]): Unit \ Write(r) =
        let mode1 = Basis/Text/Collator.marshallDecompositionMode(mode);
        Interop/Text/Collator.setDecomposition!(mode1, col)


    pub def setStrength!(strength: CollatorStrength, col: MutCollator[r]): Unit \ Write(r) =
        let strength1 = Basis/Text/Collator.marshallCollatorStrength(strength);
        Interop/Text/Collator.setStrength!(strength1, col)
        
}
