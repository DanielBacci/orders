# Orders

Order is a Python API for managing E-Commerce's orders.

## Installation

### Suggestion use Pyenv + PyenvVirtualenv
```
brew update
brew install pyenv pyenvvirtualenv
```

```bash
brew update
brew install pyenv pyenvvirtualenv
```

After installation, you'll still need to add
```bash
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

Create a new Virtualenv
```bash
pyenvirtualenv orders 3.8.2
pyenvirtualenv activate orders
```

Install Dependecies
```bash
make install-<environment> (production/developement/sandbox)
```

## Run

### Run Api Local
```bash
make run
```

### Run Tests
```bash
make test
```

* Match test
```bash
make test Q=<name>
```

### Run Integration Tests 
```bash
make integration
```

## Diagram

![Diagram](/images/diagram.png)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update the tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)