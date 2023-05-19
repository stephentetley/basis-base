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

    use Interop.Util.Locale
    use Interop.Text.MutCollator
    use Interop.Text.RuleBasedCollator.{RuleBasedCollator}

    use Basis.Text.RuleBasedCollator
    use Basis.Text.CollatorBuilder
    use Basis.Text.Collator.CollatorStrength
    use Basis.Text.Collator.DecompositionMode
  

    /// TODO change Interop.Text.CollatorInit[e: Eff, r: Region] = MutCollator[r] -> Result[String, Unit] \ {ef, r}
    def mkInit(ma: CollatorBuilder[a, r, ef, a], col: MutCollator[r]): Unit \ r = 
        unchecked_cast((
            match Graded.Builder.runBuilder(ma, col) {
            case Ok(_)  => ()
            case Err(_) => ()
        }) as _ \ r)


    ///
    /// Get a Collator from the rules.
    /// Apply the setters in `props` to further configure the Collator.
    ///
    pub def new(rc: Region[r], rules: String, init: CollatorBuilder[a, r, ef, a]): Result[String, RuleBasedCollator] \ {ef, r} =
        let fn = mkInit(init);
        unchecked_cast(Interop.Text.RuleBasedCollator.new(rc, rules, fn) as _ \ {ef, r})
    
        


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
            


}
