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
    pub enum Collator(##java.text.Collator)
    
    /// Design Note - ideally Collator would be immutable (possibly with a 
    /// builder to initially configure it)

}

namespace Basis/Text/Collator {

    use Basis/Text.Collator;
    use Basis/Text.Collator.{Collator};

    use Basis/I18n.Locale;



    // Note - Java's Collator dates from 1.1 and predates enums (1.5), I think the use of 
    // enums here is safe.

    pub enum DecompositionMode with Eq, Order, ToString, Hash, Boxable {
        case NoDecomposition
        case CanonicalDecomposition
        case FullDecomposition
    }

    pub enum CollatorStrength with Eq, Order, ToString, Hash, Boxable {
        case Identical
        case Primary
        case Secondary
        case Tertiary
    }


    pub def marshallDecompositionMode(x: DecompositionMode): Int32 =
        match x {
            case NoDecomposition        => Interop/Text/Collator.no_decomposition()
            case CanonicalDecomposition => Interop/Text/Collator.canonical_decomposition()
            case FullDecomposition      => Interop/Text/Collator.full_decomposition()
        }

    /// Fallback or bug! ?
    def unmarshallDecompositionMode(i: Int32): DecompositionMode =
        match i {
            case n if n == Interop/Text/Collator.no_decomposition()         => NoDecomposition
            case n if n == Interop/Text/Collator.canonical_decomposition()  => CanonicalDecomposition
            case n if n == Interop/Text/Collator.full_decomposition()       => FullDecomposition
            case n                                                          => bug!("unmarshallDecompositionMode: ${n}")
        }

    pub def marshallCollatorStrength(x: CollatorStrength): Int32 =
        match x {
            case Identical => Interop/Text/Collator.identical()
            case Primary   => Interop/Text/Collator.primary()
            case Secondary => Interop/Text/Collator.secondary()
            case Tertiary  => Interop/Text/Collator.tertiary()
        }

    /// Warning - I am not sure each enum has a distinct int value in Java land...
    def unmarshallCollatorStrength(i: Int32): CollatorStrength =
        match i {
            case n if n == Interop/Text/Collator.identical()    => Identical
            case n if n == Interop/Text/Collator.primary()      => Primary
            case n if n == Interop/Text/Collator.secondary()    => Secondary
            case n if n == Interop/Text/Collator.tertiary()     => Tertiary
            case n                                              => bug!("unmarshallCollatorStrength: ${n}")
        }

    def toInteropCollator(r: Region[r], df: Collator): Interop/Text.Collator[r] = 
        let Collator(df1) = df;
        Interop/Text/Collator.wrapHH(r, df1)

    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(s1: String, s2: String, col: Collator): Bool = region r {
        toInteropCollator(r, col) |> Interop/Text/Collator.equals(s1, s2)
    }

    ///
    /// Compare strings `s1` and `s2` with the collator `x``.
    ///
    pub def compare(s1: String, s2: String, col: Collator): Comparison = region r {
        toInteropCollator(r, col) |> Interop/Text/Collator.compare(s1, s2)
    }

    pub def getDecomposition(col: Collator): DecompositionMode = region r {
        toInteropCollator(r, col) |> Interop/Text/Collator.getDecomposition |> unmarshallDecompositionMode
    }


    pub def getStrength(col: Collator): CollatorStrength = region r {
        toInteropCollator(r, col) |> Interop/Text/Collator.getStrength |> unmarshallCollatorStrength
    }

        
}
