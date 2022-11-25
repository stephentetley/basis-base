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
    
    /// Treat as immutable
    /// Represents a DecimalFormat.
    ///
    pub enum DecimalFormatSymbols(##java.text.DecimalFormatSymbols)

}


namespace Basis/Text/DecimalFormatSymbols {

    use Basis/Text.DecimalFormatSymbols
    use Basis/Text.DecimalFormatSymbols.{DecimalFormatSymbols}
    // use Basis/I18n.Locale;
    // use Basis/I18n.Currency;

    def toInteropDecimalFormatSymbols(r: Region[r], syms: DecimalFormatSymbols): Interop/Text.DecimalFormatSymbols[r] = 
        let DecimalFormatSymbols(syms1) = syms;
        Interop/Text/DecimalFormatSymbols.wrapHH(r, syms1)



    pub def hashCode(df: DecimalFormatSymbols): Int32 = region r {
        toInteropDecimalFormatSymbols(r, df) |> Interop/Text/DecimalFormatSymbols.hashCode
    }

    pub def equals(x: DecimalFormatSymbols, y: DecimalFormatSymbols): Bool = region r {
        let x1 = toInteropDecimalFormatSymbols(r, x);
        let y1 = toInteropDecimalFormatSymbols(r, y);
        Interop/Text/DecimalFormatSymbols.equals(x1, y1)
    }

}
