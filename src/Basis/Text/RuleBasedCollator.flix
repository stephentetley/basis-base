/*
 * Copyright 2023 Stephen Tetley
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
    
    ///
    /// Represents a RuleBasedCollator.
    ///
    pub type alias RuleBasedCollator = Interop.Text.RuleBasedCollator
    

}

mod Basis.Text.RuleBasedCollator {

    use Basis.Text.RuleBasedCollator
    use Basis.Text.Collator.CollatorStrength
    use Basis.Text.Collator.DecompositionMode
    use Interop.Text.RuleBasedCollator.{RuleBasedCollator}
    use Interop.Util.Locale
  
/*
    pub type alias CollatorProperty[r: Region] = Basis.Text.Collator.CollatorProperty[r]

    ///
    /// Get a Collator from the rules.
    /// Apply the setters in `props` to further configure the Collator.
    ///
    pub def new(rc: Region[r], rules: String, props: List[CollatorProperty[r]]): Result[String, RuleBasedCollator] \ r =
        let combine = (f, f1) -> a -> {f(a); f1(a)};
        let fn = List.foldLeft(combine, _ -> checked_ecast(()), props);
        Interop.Text.RuleBasedCollator.new(rc, rules, fn)
    
        


    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(s1: String, s2: String, c: RuleBasedCollator): Bool = 
        Interop.Text.SubCollator.toCollator(c) |> Interop.Text.Collator.equals(s1, s2)


    ///
    /// Compare strings `s1` and `s2` with the collator `x``.
    ///
    pub def compare(s1: String, s2: String, c: RuleBasedCollator): Comparison = 
        Interop.Text.SubCollator.toCollator(c) |> Interop.Text.Collator.compare(s1, s2)


    pub def getDecomposition(c: RuleBasedCollator): DecompositionMode =
        Interop.Text.SubCollator.toCollator(c) |> Basis.Text.Collator.getDecomposition
            
    pub def getStrength(c: RuleBasedCollator): CollatorStrength =
        Interop.Text.SubCollator.toCollator(c) |> Basis.Text.Collator.getStrength
            
*/

}
