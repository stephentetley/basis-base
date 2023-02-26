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

    pub type alias MutDecimalFormat[r: Region] = Interop/Text.DecimalFormat[r]

    pub enum DecimalFormatBuilder[r: Region, ka: Type, ef: Bool, a: Type](Graded.Builder[r, ka, Interop/Text.DecimalFormat, ef, a])

    instance GradedFunctor[DecimalFormatBuilder[r, ka]] {
        pub def map(f: a -> b \ ef1, ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1, b] =
            Basis/Text/MutDecimalFormat.map(f, ma)
    }

    instance GradedApplicative[DecimalFormatBuilder[r, ka]] {
        pub def point(x: a): DecimalFormatBuilder[r, ka, ef, a] =
            Basis/Text/MutDecimalFormat.point(x)

        pub def ap(mf: DecimalFormatBuilder[r, ka, ef1, a -> b \ ef2], 
                    ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1 and ef2, b] =
            Basis/Text/MutDecimalFormat.ap(mf, ma)
    }

    instance GradedMonad[DecimalFormatBuilder[r, ka]] {
        pub def flatMap(f: a -> DecimalFormatBuilder[r, ka, ef1, b] \ ef2, 
                        ma: DecimalFormatBuilder[r, ka,ef, a]): DecimalFormatBuilder[r, ka, ef and ef1 and ef2, b] =
            Basis/Text/MutDecimalFormat.flatMap(f, ma)
    }


}


namespace Basis/Text/MutDecimalFormat {

    use Basis/Text.MutDecimalFormat;
    use Basis/Text.DecimalFormatBuilder;
    use Basis/Text.DecimalFormatBuilder.{DecimalFormatBuilder};
    use Basis/Text.DecimalFormat;
    use Basis/Text.DecimalFormat.{DecimalFormat};
    use Basis/Math/RoundingMode.RoundingMode;
    use Basis/Util.Locale;
    use Basis/Util.Currency;

    def getDecimalFormatBuilder(x: DecimalFormatBuilder[r, ka, ef, a]): Graded.Builder[r, ka, Interop/Text.DecimalFormat, ef, a] =
        let DecimalFormatBuilder(x1) = x;
        x1

    pub def point(x: a): DecimalFormatBuilder[r, ka, ef, a] =
        DecimalFormatBuilder(Graded/Builder.point(x))

    pub def map(f: a -> b \ ef1, ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1, b] =
        DecimalFormatBuilder(Graded/Builder.map(f, getDecimalFormatBuilder(ma)))

    pub def ap(mf: DecimalFormatBuilder[r, ka, ef1, a -> b \ ef2], 
                ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1 and ef2, b] =
        DecimalFormatBuilder(Graded/Builder.ap(getDecimalFormatBuilder(mf), getDecimalFormatBuilder(ma)))


    pub def flatMap(f: a -> DecimalFormatBuilder[r, ka, ef1, b] \ ef2, 
                    ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1 and ef2, b] =
        DecimalFormatBuilder(Graded/Builder.flatMap(f >> getDecimalFormatBuilder, getDecimalFormatBuilder(ma)))

    pub def throwError(msg: String): DecimalFormatBuilder[r, ka, ef, a] =
        DecimalFormatBuilder(Graded/Builder.throwError(msg))

    
    def liftSetter!(f: Interop/Text.DecimalFormat[r] -> a \ {ef, Write(r)}): DecimalFormatBuilder[r, ka, ef and r, a] =
        DecimalFormatBuilder(Graded/Builder.liftSetter!(f))


    def liftSetterResult!(f: Interop/Text.DecimalFormat[r] -> Result[err, a] \ {ef, Write(r)}): DecimalFormatBuilder[r, ka, ef and r, a] with ToString[err] =
        DecimalFormatBuilder(Graded/Builder.liftSetterResult!(f))

    // def liftGetter(f: Interop/Text.DecimalFormat[r] -> a \ ef): DecimalFormatBuilder[r, ka, a] \ ef =
    //     DecimalFormatBuilder(Graded/Builder.liftGetter(f))

    // def liftGetterResult(f: Interop/Text.DecimalFormat[r] -> Result[err, a] \ ef): DecimalFormatBuilder[r, ka, a] \ ef with ToString[err] =
    //     DecimalFormatBuilder(Graded/Builder.liftGetterResult(f))



    pub def new(r: Region[r]): MutDecimalFormat[r] \ {IO, Write(r)} =
        Interop/Text/DecimalFormat.new(r)


    pub def newWithPattern(r: Region[r], patt: String): MutDecimalFormat[r] \ {IO, Write(r)} =
        Interop/Text/DecimalFormat.newWithPattern(r, patt)

    pub def newWithLocale(r: Region[r], patt: String, loc: Locale): MutDecimalFormat[r] \ Write(r) =
        let dfs = Interop/Text/DecimalFormatSymbols.newWithLocale(r, loc);
        Interop/Text/DecimalFormat.newWithDecimalFormatSymbols(r, patt, dfs)


    pub def freeze(df: MutDecimalFormat[r]): DecimalFormat \ Read(r) =
        (unsafe_cast Interop/Text/DecimalFormat.getHH(df) as _ \ Read(r)) |> DecimalFormat


    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(ma: DecimalFormatBuilder[r, a, ef, a],
                    s: Interop/Text.DecimalFormat[r]): Result[String, a] \ ef =
        Graded/Builder.runBuilder(getDecimalFormatBuilder(ma), s)

    /// Returns an immutable DecimalFormat
    pub def build(_: Region[r], df: MutDecimalFormat[r], ma: DecimalFormatBuilder[r, a, ef, a]): Result[String, DecimalFormat] \ {r, ef} =
        match runBuilder(ma, df) {
            case Err(msg) => Err(msg)
            case Ok(_)    => freeze(df) |> Ok
        }

    pub def setCurrency!(cur: Currency): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetterResult!(Interop/Text/DecimalFormat.setCurrency!(cur))

    pub def setGroupingSize!(sz: Int32): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setGroupingSize!(sz))

    /// TODO - how to use superclass methods?
    // pub def setGroupingUsed!(b: Bool): DecimalFormatBuilder[r, ka, r, Unit] = 
    //     liftSetter!(nf -> region rc { Interop/Text/SubNumberFormat.toNumberFormat(rc, nf) |> Interop/Text/NumberFormat.setGroupingUsed!(b) })

    pub def setMaximumIntegerDigits!(n: Int32): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setMaximumIntegerDigits!(n))

    pub def setMinimumIntegerDigits!(n: Int32): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setMinimumIntegerDigits!(n))

    pub def setMaximumFractionDigits!(n: Int32): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setMaximumFractionDigits!(n))

    pub def setMinimumFractionDigits!(n: Int32): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setMinimumFractionDigits!(n))

    pub def setNegativePrefix!(s: String): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setNegativePrefix!(s))

    pub def setNegativeSuffix!(s: String): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setNegativeSuffix!(s))

    pub def setPositivePrefix!(s: String): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setPositivePrefix!(s))

    pub def setPositiveSuffix!(s: String): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetter!(Interop/Text/DecimalFormat.setPositiveSuffix!(s))


    pub def setRoundingMode!(mode: RoundingMode): DecimalFormatBuilder[r, ka, r, Unit] =
        let mode1 = Basis/Math/RoundingMode.marshallRoundingMode(mode);
        liftSetterResult!(Interop/Text/DecimalFormat.setRoundingMode!(mode1))

    pub def applyPattern!(patt: String): DecimalFormatBuilder[r, ka, r, Unit] =
        liftSetterResult!(Interop/Text/DecimalFormat.applyPattern!(patt))
}
