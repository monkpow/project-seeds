import CounterNik exposing (update, view)
import StartApp.Simple exposing (start)

main = start { model = 0, update = CounterNik.update, view = CounterNik.view }
