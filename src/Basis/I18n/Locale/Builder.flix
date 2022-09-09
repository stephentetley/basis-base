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

namespace Basis/I18n/Locale {


    ///
    ///
    pub enum Builder[r: Region, ka: Type, a: Type](MonadLib.MutStateError[r, ka, Interop/Util/Locale.Builder[r], a])


    instance Functor[Builder[r, ka]] {
        pub def map(f: a -> b & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef = 
            Basis/I18n/Locale/Builder.map(f, ma)
    }

    instance Applicative[Builder[r, ka]] {
        pub def point(x: a): Builder[r, ka, a] = 
            Basis/I18n/Locale/Builder.point(x)
            
        pub def ap(mf: Builder[r, ka, a -> b & ef], ma: Builder[r, ka, a]): Builder[r, ka, b] & ef = 
            Basis/I18n/Locale/Builder.ap(mf, ma)
    }

    instance Monad[Builder[r, ka]] {
        pub def flatMap(f: a -> Builder[r, ka, b] & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
            Basis/I18n/Locale/Builder.flatMap(f, ma)
    }

}


namespace Basis/I18n/Locale/Builder {

    use Basis/I18n/Locale.Builder;
    use Basis/I18n/Locale.Builder.{Builder};

    use Basis/I18n.Locale;
    use Basis/I18n.Locale.{Locale};


    pub def getBuilder(x: Builder[r, ka, a]): MonadLib.MutStateError[r, ka, Interop/Util/Locale.Builder[r], a] = 
        let Builder(x1) = x;
        x1


    pub def point(x: a): Builder[r, ka, a] = Builder(MonadLib/MutStateError.point(x))

    pub def map(f: a -> b & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
        Builder(MonadLib/MutStateError.map(f, getBuilder(ma)))
        
    pub def ap(mf: Builder[r, ka, a -> b & ef], ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
        Builder(MonadLib/MutStateError.ap(getBuilder(mf), getBuilder(ma)))

    pub def flatMap(f: a -> Builder[r, ka, b] & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
        Builder(MonadLib/MutStateError.flatMap(f >> getBuilder, getBuilder(ma)))

    pub def throwError(msg: String): Builder[r, ka, a] = 
        Builder(MonadLib/MutStateError.throwError(msg))


    def liftSetter!(f: Interop/Util/Locale.Builder[r] -> Interop/Util/Locale.Builder[r] \ ef): Builder[r, ka, Unit] \ ef =
        Builder(MonadLib/MutStateError.liftSetter!(f) |> Functor.ignore)

    def liftSetterResult!(f: Interop/Util/Locale.Builder[r] -> Result[Interop/Util/Locale.Builder[r], err] \ ef): Builder[r, ka, Unit] \ ef with ToString[err] =
        Builder(MonadLib/MutStateError.liftSetterResult!(f) |> Functor.ignore)

    // def liftGetter(f: Interop/Util/Locale.Builder[r] -> a \ ef): Builder[r, ka, a] \ ef =
    //     Builder(MonadLib/MutStateError.liftGetter(f))

    // def liftGetterResult(f: Interop/Util/Locale.Builder[r] -> Result[a, err] \ ef): Builder[r, ka, a] \ ef with ToString[err] =
    //     Builder(MonadLib/MutStateError.liftGetterResult(f))


    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(r: Region[r], 
                        ma: Builder[r, a, a], 
                        s: Interop/Util/Locale.Builder[r]): Result[a, String] \ r = 
        MonadLib/MutStateError.runMutStateError(r, getBuilder(ma), s)


    pub def build(r: Region[r], ma: Builder[r, a, a]): Result[Locale, String] \{ Read(r), Write(r) } = 
        let state1 = Interop/Util/Locale/Builder.new(r);
        match runBuilder(r, ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Ok(Locale(Interop/Util/Locale/Builder.build(state1)))
        }


    pub def clear!(): Builder[r, ka, Unit] \ Write(r) = 
        liftSetter!(Interop/Util/Locale/Builder.clear!)

    pub def clearExtensions!(): Builder[r, ka, Unit] \ Write(r) = 
        liftSetter!(Interop/Util/Locale/Builder.clearExtensions!)

    pub def setExtension(k: Char, v: String): Builder[r, ka, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setExtension!(k, v))

    pub def setUnicodeLocaleKeyword!(k: String, ty: String): Builder[r, ka, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.setUnicodeLocaleKeyword!(k, ty))

    pub def setLanguage!(lang: String): Builder[r, ka, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setLanguage!(lang))

    pub def setLanguageTag!(tag: String): Builder[r, ka, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.setLanguageTag!(tag))

    pub def setLocale!(loc: Locale): Builder[r, ka, Unit] \ Write(r) = 
        let Locale(loc1) = loc;
        liftSetterResult!(Interop/Util/Locale/Builder.setLocale!(loc1))

    pub def setRegion!(rgn: String): Builder[r, ka, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setRegion!(rgn))


    pub def setScript!(script: String): Builder[r, ka, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.setScript!(script))

    pub def setVariant!(vrnt: String): Builder[r, ka, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.setVariant!(vrnt))

    
    pub def addUnicodeLocaleAttribute!(attr: String): Builder[r, ka, Unit] \ Write(r) = 
        liftSetterResult!(Interop/Util/Locale/Builder.addUnicodeLocaleAttribute!(attr))

    pub def removeUnicodeLocaleAttribute!(attr: String): Builder[r, ka, Unit] \ Write(r) =
        liftSetterResult!(Interop/Util/Locale/Builder.removeUnicodeLocaleAttribute!(attr))

}   
