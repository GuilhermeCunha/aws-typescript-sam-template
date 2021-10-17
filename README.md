# aws-typescript-sam-template



## How to run
First of all, you must create the project configuration files.

```bash
# Create the samconfig file
cp samconfig.example.toml samconfig.toml

# Create the env file
cp env.example.json env.json
```

### Development
```bash
# Install dependencies
npm install

# Run application in development
npm run dev
```

### Test
```bash
# Install dependencies
npm install

# Run application in development
npm run test
```

### Build
```bash
# Install dependencies
npm install

# Run application in development
npm run sam:build
```