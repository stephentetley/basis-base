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

mod Basis.Util {


    pub type alias Currency = Interop.Util.Currency

    /// Note - Currency is an oddity because a currency is immutable, but there are no Currency 
    /// constructors (in Java), only `getInstance` static methods.
    /// 


}



mod Basis.Util.Currency {

    use Basis.Util.Currency
    use Interop.Util.Currency.{Currency}
    

    pub def getAvailableCurrencies(): List[Currency] \ IO = region r {
        Interop.Util.Currency.getAvailableCurrencies(r)
            |> Interop.Util.SetZ.toFlixList(o -> Currency(unchecked_cast(o as ##java.util.Currency)))
    }



    pub def getInstance(code: String): Result[String, Currency] \ IO = 
        Interop.Util.Currency.getInstance(code)

    pub def getInstanceWithLocale(loc: Locale): Result[String, Currency] \ IO = 
        Interop.Util.Currency.getInstanceWithLocale(loc)

    pub def getCurrencyCode(cur: Currency): String = 
        Interop.Util.Currency.getCurrencyCode(cur)

    pub def getNumericCode(cur: Currency): Int32 = 
        Interop.Util.Currency.getNumericCode(cur)

    pub def getDisplayName(cur: Currency): String = 
        Interop.Util.Currency.getDisplayName(cur)

    pub def getSymbol(cur: Currency): String = 
        Interop.Util.Currency.getSymbol(cur)

}
