# runner
import Icarus


while True:
    text = input("Icarus >>> ")
    result, error = Icarus.run('<stdin>', text)

    if error:
        print(error.as_string())
    else:
        print(result)