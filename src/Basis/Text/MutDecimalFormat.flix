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

    pub enum DecimalFormatBuilder[r: Region, ka: Type, ef: Bool, a: Type](Graded.MutStateError[ka, Interop/Text.DecimalFormat[r], ef, a])

    instance GradedFunctor[DecimalFormatBuilder[r, ka]] {
        pub def map(f: a -> b \ ef1, ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1, b] =
            Basis/Text/MutDecimalFormat.map(f, ma)
    }

    instance GradedApplicative[DecimalFormatBuilder[r, ka]] {
        pub def point(x: a): DecimalFormatBuilder[r, ka, Pure, a] =
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

    def getDecimalFormatBuilder(x: DecimalFormatBuilder[r, ka, ef, a]): Graded.MutStateError[ka, Interop/Text.DecimalFormat[r], ef, a] =
        let DecimalFormatBuilder(x1) = x;
        x1

    pub def point(x: a): DecimalFormatBuilder[r, ka, Pure, a] =
        DecimalFormatBuilder(Graded/MutStateError.point(x))

    pub def map(f: a -> b \ ef1, ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1, b] =
        DecimalFormatBuilder(Graded/MutStateError.map(f, getDecimalFormatBuilder(ma)))

    pub def ap(mf: DecimalFormatBuilder[r, ka, ef1, a -> b \ ef2], 
                ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1 and ef2, b] =
        DecimalFormatBuilder(Graded/MutStateError.ap(getDecimalFormatBuilder(mf), getDecimalFormatBuilder(ma)))


    pub def flatMap(f: a -> DecimalFormatBuilder[r, ka, ef1, b] \ ef2, 
                    ma: DecimalFormatBuilder[r, ka, ef, a]): DecimalFormatBuilder[r, ka, ef and ef1 and ef2, b] =
        DecimalFormatBuilder(Graded/MutStateError.flatMap(f >> getDecimalFormatBuilder, getDecimalFormatBuilder(ma)))

    pub def throwError(msg: String): DecimalFormatBuilder[r, ka, ef, a] =
        DecimalFormatBuilder(Graded/MutStateError.throwError(msg))

    // def liftSetter(f: Interop/Text.DecimalFormat[r] -> Interop/Text.DecimalFormat[r] \ ef): DecimalFormatBuilder[r, ka, Unit] \ ef =
    //     DecimalFormatBuilder(Graded/Builder.liftSetter(f))

    def liftSetter!(f: Interop/Text.DecimalFormat[r] -> a \ ef): DecimalFormatBuilder[r, ka, ef, a] =
        DecimalFormatBuilder(Graded/MutStateError.liftSetter!(f))


    def liftSetterResult!(f: Interop/Text.DecimalFormat[r] -> Result[err, a] \ ef): DecimalFormatBuilder[r, ka, ef, a] with ToString[err] =
        DecimalFormatBuilder(Graded/MutStateError.liftSetterResult!(f))

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

    ///
    pub def freeze(df: MutDecimalFormat[r]): DecimalFormat =
        Interop/Text/DecimalFormat.getHH(df) |> DecimalFormat


    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(r: Region[r],
                    ma: DecimalFormatBuilder[r, a, ef, a],
                    s: Interop/Text.DecimalFormat[r]): Result[String, a] \ { ef, r } =
        Graded/MutStateError.runMutStateError(r, getDecimalFormatBuilder(ma), s)

    /// Returns an immutable DecimalFormat
    /// TODO - should build on an initial `DecimalFormat` to avoid proliferating `build...` functions
    pub def build(rh: Region[r], df: MutDecimalFormat[r], ma: DecimalFormatBuilder[r, a, ef, a]): Result[String, DecimalFormat] \ { ef, Write(r) } =
        match runBuilder(rh, ma, df) {
            case Err(msg) => Err(msg)
            case Ok(_)    => freeze(df) |> Ok
        }

    pub def setCurrency!(cur: Currency): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetterResult!(Interop/Text/DecimalFormat.setCurrency!(cur))

    pub def setGroupingSize!(sz: Int32): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setGroupingSize!(sz))

    pub def setGroupingUsed!(b: Bool): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/SubNumberFormat.toNumberFormat >> Interop/Text/NumberFormat.setGroupingUsed!(b))


    pub def setMaximumIntegerDigits!(n: Int32): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setMaximumIntegerDigits!(n))

    pub def setMinimumIntegerDigits!(n: Int32): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setMinimumIntegerDigits!(n))

    pub def setMaximumFractionDigits!(n: Int32): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setMaximumFractionDigits!(n))

    pub def setMinimumFractionDigits!(n: Int32): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setMinimumFractionDigits!(n))

    pub def setNegativePrefix!(s: String): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setNegativePrefix!(s))

    pub def setNegativeSuffix!(s: String): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setNegativeSuffix!(s))

    pub def setPositivePrefix!(s: String): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setPositivePrefix!(s))

    pub def setPositiveSuffix!(s: String): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetter!(Interop/Text/DecimalFormat.setPositiveSuffix!(s))


    pub def setRoundingMode!(mode: RoundingMode): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        let mode1 = Basis/Math/RoundingMode.marshallRoundingMode(mode);
        liftSetterResult!(Interop/Text/DecimalFormat.setRoundingMode!(mode1))

    pub def applyPattern!(patt: String): DecimalFormatBuilder[r, ka, ef, Unit] \ Write(r) =
        liftSetterResult!(Interop/Text/DecimalFormat.applyPattern!(patt))
}
