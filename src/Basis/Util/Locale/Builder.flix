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

namespace Basis/Util/Locale {


    ///
    ///
    pub enum Builder[r: Region, ka: Type, ef: Bool, a: Type](Graded.MutStateError[ka, Interop/Util/Locale.Builder[r], ef, a])


    instance GradedFunctor[Builder[r, ka]] {
        pub def map(f: a -> b \ ef1, ma: Builder[r, ka, ef, a]): Builder[r, ka, ef and ef1, b] = 
            Basis/Util/Locale/Builder.map(f, ma)
    }

    instance GradedApplicative[Builder[r, ka]] {
        pub def point(x: a): Builder[r, ka, Pure, a] = 
            Basis/Util/Locale/Builder.point(x)
            
        pub def ap(mf: Builder[r, ka, ef1, a -> b \ ef2], ma: Builder[r, ka, ef, a]): Builder[r, ka, ef and ef1 and ef2, b] = 
            Basis/Util/Locale/Builder.ap(mf, ma)
    }

    instance GradedMonad[Builder[r, ka]] {
        pub def flatMap(f: a -> Builder[r, ka, ef1, b] \ ef2, ma: Builder[r, ka, ef, a]): Builder[r, ka, ef and ef1 and ef2, b] =
            Basis/Util/Locale/Builder.flatMap(f, ma)
    }

}


namespace Basis/Util/Locale/Builder {

    use Basis/Util/Locale.Builder
    use Basis/Util/Locale.Builder.{Builder}

    use Basis/Util.Locale


    pub def getBuilder(x: Builder[r, ka, ef, a]): Graded.MutStateError[ka, Interop/Util/Locale.Builder[r], ef, a] = 
        let Builder(x1) = x;
        x1


    pub def point(x: a): Builder[r, ka, ef, a] = Builder(Graded/MutStateError.point(x))

    pub def map(f: a -> b \ ef1, ma: Builder[r, ka, ef, a]): Builder[r, ka, ef and ef1, b] =
        Builder(Graded/MutStateError.map(f, getBuilder(ma)))
        
    pub def ap(mf: Builder[r, ka, ef1, a -> b \ ef2], ma: Builder[r, ka, ef, a]): Builder[r, ka, ef and ef1 and ef2, b] =
        Builder(Graded/MutStateError.ap(getBuilder(mf), getBuilder(ma)))

    pub def flatMap(f: a -> Builder[r, ka, ef1, b] \ ef2, ma: Builder[r, ka, ef, a]): Builder[r, ka, ef and ef1 and ef2, b] =
        Builder(Graded/MutStateError.flatMap(f >> getBuilder, getBuilder(ma)))

    pub def throwError(msg: String): Builder[r, ka, ef, a] = 
        Builder(Graded/MutStateError.throwError(msg))


    def liftSetter!(f: Interop/Util/Locale.Builder[r] -> Interop/Util/Locale.Builder[r] \ ef): Builder[r, ka, ef, Unit] =
        Builder(Graded/MutStateError.liftSetter!(f) |> Functor.ignore)

    def liftSetterResult!(f: Interop/Util/Locale.Builder[r] -> Result[err, Interop/Util/Locale.Builder[r]] \ ef): Builder[r, ka, ef, Unit] with ToString[err] =
        Builder(Graded/MutStateError.liftSetterResult!(f) |> Functor.ignore)

    // def liftGetter(f: Interop/Util/Locale.Builder[r] -> a \ ef): Builder[r, ka, a] \ ef =
    //     Builder(Graded/MutStateError.liftGetter(f))

    // def liftGetterResult(f: Interop/Util/Locale.Builder[r] -> Result[err, a] \ ef): Builder[r, ka, a] \ ef with ToString[err] =
    //     Builder(Graded/MutStateError.liftGetterResult(f))


    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(r: Region[r], 
                        ma: Builder[r, a, ef, a], 
                        s: Interop/Util/Locale.Builder[r]): Result[String, a] \ { r, ef }  = 
        Graded/MutStateError.runMutStateError(r, getBuilder(ma), s)


    pub def build(r: Region[r], ma: Builder[r, a, ef, a]): Result[String, Locale] \ { ef, Read(r), Write(r) } = 
        let state1 = Interop/Util/Locale/Builder.new(r);
        match runBuilder(r, ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Ok(Interop/Util/Locale/Builder.build(state1))
        }


    pub def clear!(): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetter!(Interop/Util/Locale/Builder.clear!)

    pub def clearExtensions!(): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetter!(Interop/Util/Locale/Builder.clearExtensions!)

    pub def setExtension(k: Char, v: String): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setExtension!(k, v))

    pub def setUnicodeLocaleKeyword!(k: String, ty: String): Builder[r, ka, ef, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.setUnicodeLocaleKeyword!(k, ty))

    pub def setLanguage!(lang: String): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setLanguage!(lang))

    pub def setLanguageTag!(tag: String): Builder[r, ka, ef, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.setLanguageTag!(tag))

    pub def setLocale!(loc: Locale): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setLocale!(loc))

    pub def setRegion!(rgn: String): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setRegion!(rgn))


    pub def setScript!(script: String): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setScript!(script))

    pub def setVariant!(vrnt: String): Builder[r, ka, ef, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.setVariant!(vrnt))

    
    pub def addUnicodeLocaleAttribute!(attr: String): Builder[r, ka, ef, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.addUnicodeLocaleAttribute!(attr))

    pub def removeUnicodeLocaleAttribute!(attr: String): Builder[r, ka, ef, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.removeUnicodeLocaleAttribute!(attr))

}   
