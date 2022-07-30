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

namespace Interop/I18n/Locale {

    /// We need Errors!

    ///
    /// Reader (without local) and Error monad in codensity style to be stack safe.
    ///
    pub enum Builder[r: Region, ka: Type, a: Type](##java.util.Locale$Builder -> (a -> Result[ka, String] & r) -> Result[ka, String] & r)


    instance Functor[Builder[r, ka]] {
        pub def map(f: a -> b & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef = 
            Interop/I18n/Locale/Builder.map(f, ma)
    }

    instance Applicative[Builder[r, ka]] {
        pub def point(x: a): Builder[r, ka, a] = 
            Interop/I18n/Locale/Builder.point(x)
            
        pub def ap(mf: Builder[r, ka, a -> b & ef], ma: Builder[r, ka, a]): Builder[r, ka, b] & ef = 
            Interop/I18n/Locale/Builder.ap(mf, ma)
    }

    instance Monad[Builder[r, ka]] {
        pub def flatMap(f: a -> Builder[r, ka, b] & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
            Interop/I18n/Locale/Builder.flatMap(f, ma)
    }

}


namespace Interop/I18n/Locale/Builder {

    use Interop/I18n/Locale.Builder;
    use Interop/I18n/Locale.Builder.{Builder};

    use Interop/I18n.Locale;
    use Interop/I18n.Locale.{Locale};

    ///
    /// Helper function for the implementation of `map` and `ap` etc.
    ///
    def apply1(ma: Builder[r, ka, a], 
                s: ##java.util.Locale$Builder, 
                k: a -> Result[ka, String] & r): Result[ka, String] & r =
        let Builder(ma1) = ma;
        ma1(s, k)

    pub def build(_: Region[r], ma: Builder[r, a, a]): Result[Locale, String] \{ Read(r), Write(r) } = 
        import new java.util.Locale$Builder(): ##java.util.Locale$Builder & r as new1;
        import java.util.Locale$Builder.build(): ##java.util.Locale & r as toJavaLocale;
        try {
            let jbuilder = new1();
            match runBuilder(ma, jbuilder) {
                case Err(msg) => Err(msg)
                case Ok(_)    => Ok(Locale(toJavaLocale(jbuilder)))
            }
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & r;
                Err("build: " + getMessage(ex))
        }

    ///
    /// Returns the result (new state and answer) of applying `ma` to the initial state `st`.
    ///
    def runBuilder(ma: Builder[r, a, a], s: ##java.util.Locale$Builder): Result[a, String] & r =
        let Builder(f) = ma;
        let cont = a -> Ok(a) as & r;
        f(s, cont)

    pub def point(x: a): Builder[r, ka, a] = Builder((_, k) -> k(x))

    pub def map(f: a -> b & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
        Builder((s, k) ->
            apply1(ma, s, a -> k(f(a) as & r))
        ) as & ef
        
    pub def ap(mf: Builder[r, ka, a -> b & ef], ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
        Builder((s, k) ->
            apply1(mf, s, f ->
                apply1(ma, s, a ->
                    k(f(a) as & r)))
        ) as & ef

    pub def flatMap(f: a -> Builder[r, ka, b] & ef, ma: Builder[r, ka, a]): Builder[r, ka, b] & ef =
        Builder((s, k) ->
            apply1(ma, s, a ->
                apply1(f(a) as & r, s, b ->
                    k(b)))
        ) as & ef

    pub def throwError(msg: String): Builder[r, ka, a] = 
        Builder((_, _) -> Err(msg) as & r)


    def liftJvmBuilderPrim(f: ##java.util.Locale$Builder -> ##java.util.Locale$Builder & ef): Builder[r, ka, Unit] & ef = 
        Builder((s, k) ->
            try {
                {discard f(s); k()} as & r
            } catch {
                case ex: ##java.lang.Exception => 
                    import java.lang.Throwable.getMessage(): String & r;
                    Err("liftJvmBuilderPrim: " + getMessage(ex))
            }            
        ) as & ef

    pub def clear(): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.clear(): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(clear)

    pub def clearExtensions(): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.clearExtensions(): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(clearExtensions)

    pub def setExtension(r: {key :: Char, value :: String}): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setExtension(Char, String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(bldr -> setExtension(bldr, r.key, r.value))

    pub def setUnicodeLocaleKeyword(r: {key :: String, keywordType :: String}): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setUnicodeLocaleKeyword(String, String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(bldr -> setUnicodeLocaleKeyword(bldr, r.key, r.keywordType))

    pub def setLanguage(lang: String): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setLanguage(String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(flip(setLanguage, lang))

    pub def setLanguageTag(tag: String): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setLanguageTag(String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(flip(setLanguageTag, tag))

    pub def setLocale(loc: Locale): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setLocale(##java.util.Locale): ##java.util.Locale$Builder & r;
        let Locale(loc1) = loc;
        liftJvmBuilderPrim(flip(setLocale, loc1))

    pub def setRegion(rgn: String): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setRegion(String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(flip(setRegion, rgn))

    pub def setScript(script: String): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setScript(String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(flip(setScript, script))

    pub def setVariant(vrnt: String): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.setVariant(String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(flip(setVariant, vrnt))

    
    pub def addUnicodeLocaleAttribute(attr: String): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.addUnicodeLocaleAttribute(String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(flip(addUnicodeLocaleAttribute, attr))
    
    pub def removeUnicodeLocaleAttribute(attr: String): Builder[r, ka, Unit] \ Write(r) = 
        import java.util.Locale$Builder.removeUnicodeLocaleAttribute(String): ##java.util.Locale$Builder & r;
        liftJvmBuilderPrim(flip(removeUnicodeLocaleAttribute, attr))

}   
