# aws-typescript-sam-template



## How to run
First of all, you must create the project configuration files.


### Configure
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

### Sam Build
```bash
# Build application using sam
npm run sam:build
```


### Sam Deploy
```bash
# Build application using sam
npm run sam:build

# Deploy application using dev env (based in samconfig.yml)
npm run sam:deploy -- dev


# Deploy application using prod env (based in samconfig.yml)
npm run sam:deploy -- prod
```