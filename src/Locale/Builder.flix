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

namespace Locale {



    ///
    /// Reader (without local) and Error monad in codensity style to be stack safe.
    ///
    pub enum Builder[ka, a](##java.util.Locale$Builder -> (a -> Result[ka, String] & Impure) -> Result[ka, String] & Impure)


    instance Functor[Builder[ka]] {
        pub def map(f: a -> b & ef, ma: Builder[ka, a]): Builder[ka, b] & ef = Locale/Builder.map(f, ma)
    }


    instance Applicative[Builder[ka]] {
        pub def point(x: a): Builder[ka, a] = Locale/Builder.point(x)
        pub def ap(mf: Builder[ka, a -> b & ef], ma: Builder[ka, a]): Builder[ka, b] & ef = Locale/Builder.ap(mf, ma)
    }

    instance Monad[Builder[ka]] {
        pub def flatMap(f: a -> Builder[ka, b] & ef, ma: Builder[ka, a]): Builder[ka, b] & ef =
            Locale/Builder.flatMap(f, ma)
    }

}


namespace Locale/Builder {

    use Locale.Builder;
    use Locale.Builder.{Builder};

    ///
    /// Helper function for the implementation of `map` and `ap` etc.
    ///
    def apply1(ma: Builder[ka, a], 
                r: ##java.util.Locale$Builder, 
                k: a -> Result[ka, String] & Impure): Result[ka, String] & Impure =
        let Builder(ma1) = ma;
        ma1(r, k)

    pub def build(ma: Builder[a, a]): Result[Locale, String] & Impure = 
        import new java.util.Locale$Builder(): ##java.util.Locale$Builder & Impure as new1;
        import java.util.Locale$Builder.build(): ##java.util.Locale & Impure as toJavaLocale;
        try {
            let jbuilder = new1();
            match runBuilder(ma, jbuilder) {
                case Err(msg) => Err(msg)
                case Ok(_)    => Ok(Locale(toJavaLocale(jbuilder)))
            }
        } catch {
            case ex: ##java.lang.Exception => Err(Marshal.unmarshalException(ex))
        }

    ///
    /// Returns the result (new state and answer) of applying `ma` to the initial state `st`.
    ///
    def runBuilder(ma: Builder[a, a], r: ##java.util.Locale$Builder): Result[a, String] & Impure =
        let Builder(f) = ma;
        let cont = a -> Ok(a) as & Impure;
        f(r, cont)

    pub def point(x: a): Builder[ka, a] =
        Builder((_, k) -> k(x))

    pub def map(f: a -> b & ef, ma: Builder[ka, a]): Builder[ka, b] & ef =
        Builder((r, k) ->
            apply1(ma, r, a -> k(f(a) as & Impure))
        ) as & ef
        
    pub def ap(mf: Builder[ka, a -> b & ef], ma: Builder[ka, a]): Builder[ka, b] & ef =
        Builder((r, k) ->
            apply1(mf, r, f ->
                apply1(ma, r, a ->
                    k(f(a) as & Impure)))
        ) as & ef

    pub def flatMap(f: a -> Builder[ka, b] & ef, ma: Builder[ka, a]): Builder[ka, b] & ef =
        Builder((r, k) ->
            apply1(ma, r, a ->
                apply1(f(a) as & Impure, r, b ->
                    k(b)))
        ) as & ef

    pub def throwError(msg: String): Builder[ka, a] = 
        Builder((_, _) -> Err(msg) as & Impure)


    def liftJvmBuilderPrim(f: ##java.util.Locale$Builder -> ##java.util.Locale$Builder & Impure): Builder[ka, Unit] = 
        Builder((r, k) ->
            try {
                f(r);
                k()
            } catch {
                case ex: ##java.lang.Exception => Err(Marshal.unmarshalException(ex))
            }            
        )

    pub def clear(): Builder[ka, Unit] = 
        import java.util.Locale$Builder.clear(): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(clear)

    pub def clearExtensions(): Builder[ka, Unit] = 
        import java.util.Locale$Builder.clearExtensions(): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(clearExtensions)

    pub def setExtension(r: {key :: Char, value :: String}): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setExtension(Char, String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(bldr -> setExtension(bldr, r.key, r.value))

    pub def setUnicodeLocaleKeyword(r: {key :: String, keywordType :: String}): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setUnicodeLocaleKeyword(String, String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(bldr -> setUnicodeLocaleKeyword(bldr, r.key, r.keywordType))

    pub def setLanguage(lang: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setLanguage(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(setLanguage, lang))

    pub def setLanguageTag(tag: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setLanguageTag(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(setLanguageTag, tag))

    pub def setLocale(loc: Locale): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setLocale(##java.util.Locale): ##java.util.Locale$Builder & Impure;
        let Locale(loc1) = loc;
        liftJvmBuilderPrim(flip(setLocale, loc1))

    pub def setRegion(rgn: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setRegion(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(setRegion, rgn))

    pub def setScript(script: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setScript(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(setScript, script))

    pub def setVariant(vrnt: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setVariant(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(setVariant, vrnt))

    
    pub def addUnicodeLocaleAttribute(attr: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.addUnicodeLocaleAttribute(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(addUnicodeLocaleAttribute, attr))
    
    pub def removeUnicodeLocaleAttribute(attr: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.removeUnicodeLocaleAttribute(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(removeUnicodeLocaleAttribute, attr))

}   
