-- file: chp3/error.hs

guess :: Int -> String

guess num = if num == 10086
            then "luckly"
            else error "bad~ bad~ bad~"
