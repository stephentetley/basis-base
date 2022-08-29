/*
 * Copyright 2020 Stephen Tetley
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

namespace Basis/I18n {


    pub enum Currency(Interop/Util.Currency)

    instance ToString[Currency] {
        pub def toString(x: Currency): String = 
            let Currency(x1) = x;
            Interop/Util/Currency.toString(x1)
    }

    /// Note - Currency is an oddity because a currency is immutable, but there are no Currency 
    /// constructors (in Java), only `getInstance` static methods.
    /// 

    /// No Order, so no Boxable

    instance Interop/Flix.Marshal[Currency] {
        pub def toJavaObject(cur: Currency): ##java.lang.Object = 
            let Currency(cur1) = cur;
            Interop/Flix/Marshal.toJavaObject(cur1)
        
        pub def fromJavaObject(o: ##java.lang.Object): Currency = 
            Currency(Interop/Flix/Marshal.fromJavaObject(o))
    }

}



namespace Basis/I18n/Currency {

    use Basis/I18n.Currency;
    use Basis/I18n.Currency.{Currency};

    use Basis/I18n.Locale;
    use Basis/I18n.Locale.{Locale};

    
    pub def getCurrency(loc: Currency): Interop/Util.Currency = 
        let Currency(loc1) = loc;
        loc1

    pub def getAvailableCurrencies(): Result[List[Currency], String] \ IO = 
        Interop/Util/Currency.getAvailableCurrencies() |> Result.map(List.map(Currency))

    pub def getInstance(code: String): Result[Currency, String] \ IO = 
        Interop/Util/Currency.getInstance(code) |> Result.map(Currency)

    pub def getInstanceWithLocale(loc: Locale): Result[Currency, String] \ IO = 
        let Locale(loc1) = loc;
        Interop/Util/Currency.getInstanceWithLocale(loc1) |> Result.map(Currency)

    pub def getCurrencyCode(cur: Currency): String = 
        getCurrency(cur) |> Interop/Util/Currency.getCurrencyCode

    pub def getNumericCode(cur: Currency): Int32 = 
        getCurrency(cur) |> Interop/Util/Currency.getNumericCode

    pub def getDisplayName(cur: Currency): String = 
        getCurrency(cur) |> Interop/Util/Currency.getDisplayName

}
