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

mod Basis.Text {
    
    /// Treat as immutable
    /// Represents a DecimalFormat.
    ///
    pub type alias DecimalFormatSymbols = Interop.Text.DecimalFormatSymbols

}


mod Basis.Text.DecimalFormatSymbols {

    use Basis.Text.DecimalFormatSymbols
    use Interop.Text.DecimalFormatSymbols.{DecimalFormatSymbols}
    // use Basis.I18n.Locale
    // use Basis.I18n.Currency




    pub def hashCode(df: DecimalFormatSymbols): Int32 = Interop.Text.DecimalFormatSymbols.hashCode(df)


    pub def equals(x: DecimalFormatSymbols, y: DecimalFormatSymbols): Bool = 
        Interop.Text.DecimalFormatSymbols.equals(x, y)
    

}
