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
    /// State and Codensity(Error) monad
    ///
    pub opaque type Builder[ka, a] = ##java.util.Locale$Builder -> (a -> ##java.util.Locale$Builder -> Result[ka, String] & Impure) -> Result[ka, String] & Impure


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
                st: ##java.util.Locale$Builder, 
                k: a -> ##java.util.Locale$Builder -> Result[ka, String] & Impure): Result[ka, String] & Impure =
        let Builder(ma1) = ma;
        ma1(st, k)

    pub def build(ma: Builder[(##java.util.Locale$Builder, a), a]): Result[Locale, String] & Impure = 
        import new java.util.Locale$Builder(): ##java.util.Locale$Builder & Impure as new1;
        import java.util.Locale$Builder.build(): ##java.util.Locale & Impure as toJavaLocale;
        try {
            let jbuilder = new1();
            match runBuilder(ma, jbuilder) {
                case Err(msg)           => Err(msg)
                case Ok((jbuilder1, _)) => Ok(Locale(toJavaLocale(jbuilder1)))
            }
        } catch {
            case ex: ##java.lang.Exception => Err(Marshal.unmarshalException(ex))
        }

    ///
    /// Returns the result (new state and answer) of applying `ma` to the initial state `st`.
    ///
    def runBuilder(ma: Builder[(##java.util.Locale$Builder, a), a], st: ##java.util.Locale$Builder): Result[(##java.util.Locale$Builder, a), String] & Impure =
        let Builder(f) = ma;
        let cont = (a, s) -> Ok(s, a) as & Impure;
        f(st, cont)

    pub def point(x: a): Builder[ka, a] =
        Builder((s, k) -> k(x, s))

    pub def map(f: a -> b & ef, ma: Builder[ka, a]): Builder[ka, b] & ef =
        Builder((s, k) ->
            apply1(ma, s, (a, s1) -> k(f(a) as & Impure, s1))
        ) as & ef
        
    pub def ap(mf: Builder[ka, a -> b & ef], ma: Builder[ka, a]): Builder[ka, b] & ef =
        Builder((s, k) ->
            apply1(mf, s, (f, s1) ->
                apply1(ma, s1, (a, s2) ->
                    k(f(a) as & Impure, s2)))
        ) as & ef

    pub def flatMap(f: a -> Builder[ka, b] & ef, ma: Builder[ka, a]): Builder[ka, b] & ef =
        Builder((s, k) ->
            apply1(ma, s, (a, s1) ->
                apply1(f(a) as & Impure, s1, (b, s2) ->
                    k(b, s2)))
        ) as & ef

    pub def throwError(msg: String): Builder[ka, a] = 
        Builder((_, _) -> Err(msg) as & Impure)


    def liftJvmBuilderPrim(f: ##java.util.Locale$Builder -> ##java.util.Locale$Builder & Impure): Builder[ka, Unit] = 
        Builder((s, k) ->
            try {
                let s1 = f(s);
                k((), s1)
            } catch {
                case ex: ##java.lang.Exception => Err(Marshal.unmarshalException(ex))
            }            
        )

    pub def clear(): Builder[ka, Unit] = 
        import java.util.Locale$Builder.clear(): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(clear)

    pub def setLanguage(lang: String): Builder[ka, Unit] = 
        import java.util.Locale$Builder.setLanguage(String): ##java.util.Locale$Builder & Impure;
        liftJvmBuilderPrim(flip(setLanguage, lang))


}   
