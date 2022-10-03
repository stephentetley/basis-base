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


namespace Basis/Lang {

    pub enum ProcessBuilder[r: Region, ka: Type, a: Type](MonadLib.MutStateError[r, ka, Interop/Lang.ProcessBuilder[r], a])

    instance Functor[ProcessBuilder[r, ka]] {
        pub def map(f: a -> b \ ef, ma: ProcessBuilder[r, ka, a]): ProcessBuilder[r, ka, b] \ ef = 
            Basis/Lang/ProcessBuilder.map(f, ma)
    }

    instance Applicative[ProcessBuilder[r, ka]] {
        pub def point(x: a): ProcessBuilder[r, ka, a] =  
            Basis/Lang/ProcessBuilder.point(x)

        pub def ap(mf: ProcessBuilder[r, ka, a -> b \ ef], ma: ProcessBuilder[r, ka, a]): ProcessBuilder[r, ka, b] \ ef =
            Basis/Lang/ProcessBuilder.ap(mf, ma)
    }

    instance Monad[ProcessBuilder[r, ka]] {
        pub def flatMap(f: a -> ProcessBuilder[r, ka, b] \ ef, ma: ProcessBuilder[r, ka, a]): ProcessBuilder[r, ka, b] \ ef =
            Basis/Lang/ProcessBuilder.flatMap(f, ma)
    }

}


namespace Basis/Lang/ProcessBuilder {

    use Monad.{>>=};

    use Basis/Lang.ProcessBuilder;
    use Basis/Lang.ProcessBuilder.{ProcessBuilder};

    use Basis/Lang.Process;
    use Basis/NIO/File.Path;


    pub def getProcessBuilder(x: ProcessBuilder[r, ka, a]): MonadLib.MutStateError[r, ka, Interop/Lang.ProcessBuilder[r], a] = 
        let ProcessBuilder(x1) = x;
        x1

    pub def point(x: a): ProcessBuilder[r, ka, a] = ProcessBuilder(MonadLib/MutStateError.point(x))

    pub def map(f: a -> b \ ef, ma: ProcessBuilder[r, ka, a]): ProcessBuilder[r, ka, b] \ ef =
        ProcessBuilder(MonadLib/MutStateError.map(f, getProcessBuilder(ma)))

    pub def ap(mf: ProcessBuilder[r, ka, a -> b \ ef], ma: ProcessBuilder[r, ka, a]): ProcessBuilder[r, ka, b] \ ef =
        ProcessBuilder(MonadLib/MutStateError.ap(getProcessBuilder(mf), getProcessBuilder(ma)))


    pub def flatMap(f: a -> ProcessBuilder[r, ka, b] \ ef, ma: ProcessBuilder[r, ka, a]): ProcessBuilder[r, ka, b] \ ef =
        ProcessBuilder(MonadLib/MutStateError.flatMap(f >> getProcessBuilder, getProcessBuilder(ma)))

    pub def throwError(msg: String): ProcessBuilder[r, ka, a] =
        ProcessBuilder(MonadLib/MutStateError.throwError(msg))

    def liftSetter!(f: Interop/Lang.ProcessBuilder[r] -> Interop/Lang.ProcessBuilder[r] \ ef): ProcessBuilder[r, ka, Unit] \ ef =
        ProcessBuilder(MonadLib/MutStateError.liftSetter!(f) |> Functor.ignore)

    def liftSetterResult!(f: Interop/Lang.ProcessBuilder[r] -> Result[Interop/Lang.ProcessBuilder[r], err] \ ef): ProcessBuilder[r, ka, Unit] \ ef with ToString[err] =
        ProcessBuilder(MonadLib/MutStateError.liftSetterResult!(f) |> Functor.ignore)

    // def liftGetter(f: Interop/Lang.ProcessBuilder[r] -> a \ ef): ProcessBuilder[r, ka, a] \ ef =
    //     ProcessBuilder(MonadLib/MutStateError.liftGetter(f))

    def liftGetterResult(f: Interop/Lang.ProcessBuilder[r] -> Result[a, err] \ ef): ProcessBuilder[r, ka, a] \ ef with ToString[err] =
        ProcessBuilder(MonadLib/MutStateError.liftGetterResult(f))

    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(r: Region[r], 
                        ma: ProcessBuilder[r, a, a], 
                        s: Interop/Lang.ProcessBuilder[r]): Result[a, String] \ r = 
        MonadLib/MutStateError.runMutStateError(r, getProcessBuilder(ma), s)


    pub def start(r: Region[r], ma: ProcessBuilder[r, a, a]): Result[Process[r], String] \ { Write(r), IO } = 
        let state1 = Interop/Lang/ProcessBuilder.new(r, Nil) as \ { Write(r), IO };
        match runBuilder(r, ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Interop/Lang/ProcessBuilder.start(state1)
        }


    /// API...


    pub def command!(cmd: String, args: List[String]): ProcessBuilder[r, ka, Unit] \ Write(r) =
        liftSetter!(Interop/Lang/ProcessBuilder.command!(cmd :: args))


    pub def setDirectory!(path: Path): ProcessBuilder[r, ka, Unit] \ Write(r) = 
        use Result.flatMap;
        let step = pb -> region r1 {
            let* file1 = Basis/NIO/File/Path.toFile(r1, path);
            Ok(Interop/Lang/ProcessBuilder.directory!(file1, pb))
        };
        liftSetterResult!(step)
        

    pub def getDirectory(): ProcessBuilder[r, ka, Path] \ Read(r) = 
        liftGetterResult(Interop/Lang/ProcessBuilder.getDirectory >> Basis/NIO/File/Path.fromFile)

    pub def getEnvironment(): ProcessBuilder[r, ka, Map[String, String]] \ Read(r) = 
        liftGetterResult(Interop/Lang/ProcessBuilder.environment)

    pub def redirectErrorTo!(path: Path): ProcessBuilder[r, ka, Unit] \ Write(r) = 
        use Result.flatMap;
        let step = pb -> region r1 {
            let* file1 = Basis/NIO/File/Path.toFile(r1, path);
            Interop/Lang/ProcessBuilder.redirectErrorTo!(file1, pb) |> Ok
        };
        liftSetterResult!(step)

    pub def redirectInputTo!(path: Path): ProcessBuilder[r, ka, Unit] \ Write(r) = 
        use Result.flatMap;
        let step = pb -> region r1 {
            let* file1 = Basis/NIO/File/Path.toFile(r1, path);
            Interop/Lang/ProcessBuilder.redirectInputTo!(file1, pb) |> Ok
        };
        liftSetterResult!(step)


    pub def redirectOutputTo!(path: Path): ProcessBuilder[r, ka, Unit] \ Write(r) = 
        use Result.flatMap;
        let step = pb -> region r1 {
            let* file1 = Basis/NIO/File/Path.toFile(r1, path);
            Interop/Lang/ProcessBuilder.redirectOutputTo!(file1, pb) |> Ok
        };
        liftSetterResult!(step)
}
