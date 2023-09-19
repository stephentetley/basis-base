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

mod Basis.Text {
    
    ///
    /// Represents a Collator.
    ///
    pub type alias Collator = Interop.Text.Collator
    
    pub type alias CollatorBuilder[ka: Type, r: Region, ef: Eff, a: Type] = Graded.Builder[ka, Interop.Text.MutCollator[r], ef, a]

}

mod Basis.Text.Collator {
    
    use Graded.Builder.{liftSetter!}
    use Interop.Text.MutCollator
    use Interop.Text.Collator.{Collator}
    
    use Basis.Text.Collator
    use Basis.Text.CollatorBuilder
    use Basis.Text.Collator.DecompositionMode
    use Basis.Text.Collator.DecompositionMode.{NoDecomposition, CanonicalDecomposition, FullDecomposition}
    use Basis.Text.Collator.CollatorStrength
    use Basis.Text.Collator.CollatorStrength.{Identical, Primary, Secondary, Tertiary}
    
    
    // Note - Java's Collator dates from 1.1 and predates enums (1.5), I think the use of 
    // enums here is safe.

    pub enum DecompositionMode with Eq, Order, ToString, Hash {
        case NoDecomposition
        case CanonicalDecomposition
        case FullDecomposition
    }

    pub enum CollatorStrength with Eq, Order, ToString, Hash {
        case Identical
        case Primary
        case Secondary
        case Tertiary
    }


    pub def marshallDecompositionMode(x: DecompositionMode): Int32 =
        match x {
            case NoDecomposition        => Interop.Text.Collator.no_decomposition()
            case CanonicalDecomposition => Interop.Text.Collator.canonical_decomposition()
            case FullDecomposition      => Interop.Text.Collator.full_decomposition()
        }

    /// Fallback or bug! ?
    def unmarshallDecompositionMode(i: Int32): DecompositionMode =
        match i {
            case n if n == Interop.Text.Collator.no_decomposition()         => NoDecomposition
            case n if n == Interop.Text.Collator.canonical_decomposition()  => CanonicalDecomposition
            case n if n == Interop.Text.Collator.full_decomposition()       => FullDecomposition
            case n                                                          => bug!("unmarshallDecompositionMode: ${n}")
        }

    pub def marshallCollatorStrength(x: CollatorStrength): Int32 =
        match x {
            case Identical => Interop.Text.Collator.identical()
            case Primary   => Interop.Text.Collator.primary()
            case Secondary => Interop.Text.Collator.secondary()
            case Tertiary  => Interop.Text.Collator.tertiary()
        }

    /// Warning - I am not sure each enum has a distinct int value in Java land...
    def unmarshallCollatorStrength(i: Int32): CollatorStrength =
        match i {
            case n if n == Interop.Text.Collator.identical()    => Identical
            case n if n == Interop.Text.Collator.primary()      => Primary
            case n if n == Interop.Text.Collator.secondary()    => Secondary
            case n if n == Interop.Text.Collator.tertiary()     => Tertiary
            case n                                              => bug!("unmarshallCollatorStrength: ${n}")
        }



    /// TODO change Interop.Text.CollatorInit[e: Eff, r: Region] = MutCollator[r] -> Result[String, Unit] \ {ef, r}
    def mkInit(ma: CollatorBuilder[a, r, ef, a], col: MutCollator[r]): Unit \ r = 
        unchecked_cast((
            match Graded.Builder.runBuilder(ma, col) {
            case Ok(_)  => ()
            case Err(_) => ()
        }) as _ \ r)

    ///
    /// Get a Collator with the locale of the JVM.
    /// Apply the setters in `fs` to further configure the Collator.
    ///
    pub def getInstance(rc: Region[r], init: CollatorBuilder[a, r, ef, a]): Collator \ {ef, r, IO} =
        let fn = mkInit(init);
        unchecked_cast(Interop.Text.Collator.getInstance(rc, fn) as _ \ {ef, r, IO})



    pub def getInstanceWithLocale(rc: Region[r], loc: Locale, init: CollatorBuilder[a, r, ef, a]): Collator \ {ef, r} =
        let fn = mkInit(init);
        unchecked_cast(Interop.Text.Collator.getInstanceWithLocale(rc, loc, fn) as _ \ {ef, r})




    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(s1: String, s2: String, col: Collator): Bool = 
        Interop.Text.Collator.equals(s1, s2, col)


    ///
    /// Compare strings `s1` and `s2` with the collator `x``.
    ///
    pub def compare(s1: String, s2: String, col: Collator): Comparison = 
        Interop.Text.Collator.compare(s1, s2, col)

    pub def getDecomposition(col: Collator): DecompositionMode =
        Interop.Text.Collator.getDecomposition(col) |> unmarshallDecompositionMode


    pub def getStrength(col: Collator): CollatorStrength =
        Interop.Text.Collator.getStrength(col) |> unmarshallCollatorStrength


    pub def setDecomposition!(x: DecompositionMode): CollatorBuilder[ka, r, r, Unit] = 
        liftSetter!(Interop.Text.Collator.setDecomposition!(marshallDecompositionMode(x)))

    pub def setStrength!(x: CollatorStrength): CollatorBuilder[ka, r, r, Unit] = 
        liftSetter!(Interop.Text.Collator.setStrength!(marshallCollatorStrength(x)))

}
