import Data.List
import System.Process
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

main :: IO ()
main = shakeArgs shakeOptions $ do
    want ["poster.pdf"]

    "poster.pdf" %> \out -> do
       files <- getDirectoryFiles "." ["//*.tex","//*.m"]
       need files
       command_  [] "pdflatex" ["-halt-on-error", dropExtension out ]
       command_  [] "pdflatex" ["-halt-on-error", dropExtension out ]

    phony "clean" $ do 
       liftIO $ removeFiles "."
          $ (["tiled.pdf"] ++ )
          $  map ("poster."++) (words "log toc aux blg bbl snm out nav") 

    "tiled.pdf" %> \out -> do 
       need ["poster.pdf"] 
       command_ [] "pdfposter" (words "-O 2 -S -p a2 poster.pdf tiled.pdf")

