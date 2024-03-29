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


mod Basis.Lang {

    /// TODO just use type alias to Graded.Builder?

    pub enum ProcessBuilder[r: Region, ka: Type, ef: Eff, a: Type](Graded.Builder[ka, Interop.Lang.ProcessBuilder[r], ef, a])

    instance GradedFunctor[ProcessBuilder[r, ka]] {
        pub def map(f: a -> b \ ef1, ma: ProcessBuilder[r, ka, ef, a]): ProcessBuilder[r, ka, ef + ef1, b] = 
            Basis.Lang.ProcessBuilder.map(f, ma)
    }

    instance GradedApplicative[ProcessBuilder[r, ka]] {
        pub def point(x: a): ProcessBuilder[r, ka, ef, a] =  
            Basis.Lang.ProcessBuilder.point(x)

        pub def ap(mf: ProcessBuilder[r, ka, ef1, a -> b \ ef2], 
                    ma: ProcessBuilder[r, ka, ef, a]): ProcessBuilder[r, ka, ef + ef1 + ef2, b] =
            Basis.Lang.ProcessBuilder.ap(mf, ma)
    }

    instance GradedMonad[ProcessBuilder[r, ka]] {
        pub def flatMap(f: a -> ProcessBuilder[r, ka, ef1, b] \ ef2, 
                        ma: ProcessBuilder[r, ka, ef, a]): ProcessBuilder[r, ka, ef + ef1 + ef2, b] =
            Basis.Lang.ProcessBuilder.flatMap(f, ma)
    }

}


mod Basis.Lang.ProcessBuilder {

    use Basis.Lang.ProcessBuilder
    use Basis.Lang.ProcessBuilder.{ProcessBuilder}
    use Basis.Lang.Process
    use Basis.NIO.File.Path


    pub def getProcessBuilder(x: ProcessBuilder[r, ka, ef, a]): Graded.Builder[ka, Interop.Lang.ProcessBuilder[r], ef, a] = 
        let ProcessBuilder(x1) = x;
        x1

    pub def point(x: a): ProcessBuilder[r, ka, ef, a] = ProcessBuilder(Graded.Builder.point(x))

    pub def map(f: a -> b \ ef1, ma: ProcessBuilder[r, ka, ef, a]): ProcessBuilder[r, ka, ef + ef1, b] =
        ProcessBuilder(Graded.Builder.map(f, getProcessBuilder(ma)))

    pub def ap(mf: ProcessBuilder[r, ka, ef1, a -> b \ ef2], ma: ProcessBuilder[r, ka, ef, a]): ProcessBuilder[r, ka, ef + ef1 + ef2, b] =
        ProcessBuilder(Graded.Builder.ap(getProcessBuilder(mf), getProcessBuilder(ma)))


    pub def flatMap(f: a -> ProcessBuilder[r, ka, ef1, b] \ ef2, ma: ProcessBuilder[r, ka, ef, a]): ProcessBuilder[r, ka, ef + ef1 + ef2, b] =
        ProcessBuilder(Graded.Builder.flatMap(f >> getProcessBuilder, getProcessBuilder(ma)))

    pub def throwError(msg: String): ProcessBuilder[r, ka, ef, a] =
        ProcessBuilder(Graded.Builder.throwError(msg))

    def liftSetter!(f: Interop.Lang.ProcessBuilder[r] -> Interop.Lang.ProcessBuilder[r] \ {ef, r}): ProcessBuilder[r, ka, ef + r, Unit] =
        ProcessBuilder(Graded.Builder.liftSetter!(f) |> GradedFunctor.ignore)

    def liftSetterResult!(f: Interop.Lang.ProcessBuilder[r] -> Result[err, Interop.Lang.ProcessBuilder[r]] \ {ef, r}): ProcessBuilder[r, ka, ef + r, Unit] with ToString[err] =
        ProcessBuilder(Graded.Builder.liftSetterResult!(f) |> GradedFunctor.ignore)

    // def liftGetter(f: Interop.Lang.ProcessBuilder[r] -> a \ {ef, Read(r)}): ProcessBuilder[r, ka, ef + r, a] \ ef =
    //     ProcessBuilder(Graded.Builder.liftGetter(f))

    def liftGetterResult(f: Interop.Lang.ProcessBuilder[r] -> Result[err, a] \ {ef, r}): ProcessBuilder[r, ka, ef + r, a] with ToString[err] =
        ProcessBuilder(Graded.Builder.liftGetterResult(f))

    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(ma: ProcessBuilder[r, a, ef, a], 
                    s: Interop.Lang.ProcessBuilder[r]): Result[String, a] \ ef = 
        Graded.Builder.runBuilder(getProcessBuilder(ma), s)


    pub def start(rc: Region[r], ma: ProcessBuilder[r, a, ef, a]): Result[String, Process[r]] \ {ef, r} = 
        let state1 = Interop.Lang.ProcessBuilder.new(rc, Nil);
        match runBuilder(ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Interop.Lang.ProcessBuilder.start(rc, state1)
        }


    /// API...


    pub def command!(cmd: String, args: List[String]): ProcessBuilder[r, ka, r, Unit] =
        liftSetter!(Interop.Lang.ProcessBuilder.command!(cmd :: args))


    pub def setDirectory!(path: Path): ProcessBuilder[r, ka, r, Unit] = 
        use Functor.{<$>};
        let step = pb -> region r1 {
            flip(Interop.Lang.ProcessBuilder.directory!, pb) <$> Basis.NIO.File.Path.toFile(r1, path)
        };
        liftSetterResult!(step)

    // TODO
    // pub def getDirectory(): ProcessBuilder[r, ka, r, Path] = 
    //     liftGetterResult(Interop.Lang.ProcessBuilder.getDirectory >> Basis.NIO.File.Path.fromFile)

    pub def getEnvironment(): ProcessBuilder[r, ka, r + Impure, Map[String, String]] = 
        liftGetterResult(Interop.Lang.ProcessBuilder.environment)

    pub def redirectErrorTo!(path: Path): ProcessBuilder[r, ka, r, Unit] = 
        use Functor.{<$>};
        let step = pb -> region r1 {
            flip(Interop.Lang.ProcessBuilder.redirectErrorTo!, pb) <$> Basis.NIO.File.Path.toFile(r1, path)
        };
        liftSetterResult!(step)

    pub def redirectInputTo!(path: Path): ProcessBuilder[r, ka, r, Unit] = 
        use Functor.{<$>};
        let step = pb -> region r1 {
            flip(Interop.Lang.ProcessBuilder.redirectInputTo!, pb) <$> Basis.NIO.File.Path.toFile(r1, path)
        };
        liftSetterResult!(step)


    pub def redirectOutputTo!(path: Path): ProcessBuilder[r, ka, r, Unit] = 
        use Functor.{<$>};
        let step = pb -> region r1 {
            flip(Interop.Lang.ProcessBuilder.redirectOutputTo!, pb) <$> Basis.NIO.File.Path.toFile(r1, path)            
        };
        liftSetterResult!(step)

}
