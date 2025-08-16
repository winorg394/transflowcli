# 🚀 TransFlow CLI

A powerful command-line tool for extracting translatable text from Flutter applications and generating translation files in multiple formats.

## ✨ Features

- **Intelligent Text Extraction**: Automatically detects translatable text in Dart files using pattern matching
- **Multiple Output Formats**: Generate translation files in JSON, ARB, or both formats
- **Duplicate Detection**: Automatically removes duplicate text entries across files
- **In-Place Replacement**: Optionally replace text with translation keys in your Dart files
- **Backup Creation**: Creates backups before modifying any files
- **Pattern Recognition**: Supports various Flutter text patterns (Text widgets, properties, dialogs, etc.)
- **API Key Management**: Securely store and manage your TransFlow API keys
- **Translation Integration**: Translate ARB files using the TransFlow translation API

## 🚀 Quick Start

### Installation

```bash
# From source
git clone https://github.com/transflow/transflow-cli.git
cd transflow-cli/cli/cligen
cargo install --path .

# Or using cargo directly
cargo install --git https://github.com/transflow/transflow-cli.git
```


## For a user installation 
```bash 
iex (iwr 'https://raw.githubusercontent.com/winorg394/transflowcli/refs/heads/main/install.ps1' -UseBasicParsing).Content

```
### Basic Usage

```bash
# Extract text from current directory
transflow-cli extract

# Extract from specific project path
transflow-cli extract -p ./my_flutter_app

# Generate only JSON format
transflow-cli extract -f json

# Replace text with translation keys in files
transflow-cli extract -r

# List project folders
transflow-cli list

# Save API key for future use
transflow-cli set-api-key -k your-api-key

# Translate ARB file to French (uses saved API key)
transflow-cli translate -f app_en.arb -t fr

# Show version information
transflow-cli version --verbose
```

## 📚 Commands

### `extract` - Extract Translatable Text

Extracts translatable text from your Flutter project and generates translation files.

**Options:**
- `-p, --path <PATH>`: Path to Flutter project folder (defaults to current directory)
- `-f, --format <FORMAT>`: Output format: `json`, `arb`, or `both` (default: `both`)
- `-r, --replace-in-files`: Replace text with translation keys in Dart files

**Examples:**
```bash
# Extract from current directory
transflow-cli extract

# Extract from specific path with JSON output
transflow-cli extract -p ./my_app -f json

# Extract and replace text in files
transflow-cli extract -r
```

### `list` - List Project Folders

Lists all folders in your Flutter project to help you understand the structure.

**Options:**
- `-p, --path <PATH>`: Path to Flutter project folder (defaults to current directory)

**Example:**
```bash
transflow-cli list -p ./my_flutter_app
```

### `version` - Show Version Information

Displays version and build information about the CLI tool.

**Options:**
- `--verbose`: Show detailed version information

**Examples:**
```bash
transflow-cli version
transflow-cli version --verbose
```

### `set-api-key` - Save API Key

Saves your TransFlow API key in your system's application data directory for future use. This eliminates the need to pass `--api-key` with every translate command.

**Options:**
- `-k, --api-key <KEY>`: TransFlow API key to store (required)

**Examples:**
```bash
# Save API key for future use
transflow-cli set-api-key -k your-api-key-here

# The key is now stored and will be used automatically
transflow-cli translate -f app_en.arb -t fr
```

**Storage Locations:**
- **Windows**: `%APPDATA%\TransFlow\api_key.txt`
- **macOS**: `~/Library/Application Support/TransFlow/api_key.txt`
- **Linux**: `$XDG_CONFIG_HOME/transflow/api_key.txt` or `~/.config/transflow/api_key.txt`

### `translate` - Translate ARB Files

Translates ARB files using the TransFlow translation API. This command reads an ARB file, translates all text values to the target language, and generates a new ARB file with the translated content.

**Options:**
- `-f, --file <FILE>`: Path to input ARB file (required)
- `-t, --target <LANG>`: Target language code, e.g., fr, es, de, ja (required)
- `-o, --output <OUTPUT>`: Output ARB file path (defaults to app_{target}.arb)
- `--api-url <URL>`: TransFlow API endpoint URL (defaults to http://localhost:8000/api/v2/translate)
- `--api-key <KEY>`: TransFlow API key for authentication (optional if saved via `set-api-key`)
- `--verbose`: Show progress during translation
- `--test-api`: Test API connection without translating

**Examples:**
```bash
# Translate to French (uses saved API key if available)
transflow-cli translate -f app_en.arb -t fr

# Translate to Spanish with custom output name
transflow-cli translate -f app_en.arb -t es -o app_es.arb

# Translate using custom API endpoint
transflow-cli translate -f app_en.arb -t de --api-url https://api.transflow.dev/v2/translate

# Translate with explicit API key
transflow-cli translate -f app_en.arb -t ja --api-key your-api-key --verbose

# Test API connection
transflow-cli translate -f app_en.arb -t fr --test-api
```

## 🔧 Configuration

The tool automatically detects Flutter projects and supports various text patterns:

### Translation API Integration

The `translate` command integrates with the TransFlow translation API to provide high-quality translations:

- **Default API Endpoint**: `http://localhost:8000/api/v2/translate`
- **Authentication**: API key via `--api-key` parameter or saved configuration
- **API Key Storage**: Save your API key once with `set-api-key` command
- **Rate Limiting**: Built-in delays to avoid overwhelming the API
- **Error Handling**: Comprehensive error reporting and retry suggestions
- **Progress Tracking**: Real-time progress bars and verbose output options

### Supported Language Codes

The tool supports standard 2-letter ISO language codes:
- `fr` - French
- `es` - Spanish  
- `de` - German
- `ja` - Japanese
- `zh` - Chinese
- `ko` - Korean
- And many more...

### Supported Text Patterns

The tool automatically detects Flutter projects and supports various text patterns:

- **Text Widgets**: `Text("Hello World")`
- **Properties**: `hintText: "Enter your name"`
- **Dialogs**: `content: "Are you sure?"`
- **AppBar Titles**: `title: "My App"`
- **SnackBar Content**: `SnackBar(content: Text("Message"))`

## 📁 Output Files

The tool generates the following files in a `transflow_output` directory:

- **`translations.json`**: JSON format with metadata
- **`app_en.arb`**: ARB format for Flutter internationalization

## 🛡️ Safety Features

- **Backup Creation**: Original files are backed up with `.backup` extension
- **Dry Run**: Use without `-r` flag to see what would be changed
- **Validation**: Checks file integrity before making changes
- **Secure API Key Storage**: API keys are stored in OS-specific secure locations

## 📖 Examples

### Basic Text Extraction

```bash
# Navigate to your Flutter project
cd my_flutter_app

# Extract text and generate translation files
transflow-cli extract

# Check the output
ls transflow_output/
# Output: translations.json  app_en.arb
```

### Advanced Usage

```bash
# Extract from specific path with JSON output only
transflow-cli extract -p ./lib/screens -f json

# Extract and replace text in files (with backup)
transflow-cli extract -r

# List project structure first
transflow-cli list
```

### Translation Workflow

```bash
# 1. Extract text from your Flutter project
transflow-cli extract -p ./my_flutter_app

# 2. Check the generated ARB file
cat transflow_output/app_en.arb

# 3. Save your API key (one-time setup)
transflow-cli set-api-key -k your-api-key-here

# 4. Translate to French (uses saved API key)
transflow-cli translate -f transflow_output/app_en.arb -t fr

# 5. Translate to Spanish (uses saved API key)
transflow-cli translate -f transflow_output/app_en.arb -t es

# 6. Use the translated files in your Flutter app
# app_fr.arb, app_es.arb are now ready for use
```

### API Key Management

```bash
# Save your API key securely (one-time setup)
transflow-cli set-api-key -k your-api-key-here

# Verify the key is stored (optional)
ls ~/.config/transflow/api_key.txt  # Linux/macOS
# or
dir %APPDATA%\TransFlow\api_key.txt  # Windows

# Use translation without specifying API key
transflow-cli translate -f app_en.arb -t fr

# Override saved key for a specific command
transflow-cli translate -f app_en.arb -t es --api-key different-key

# Test API connection
transflow-cli translate -f app_en.arb -t fr --test-api
```

## 🔍 Troubleshooting

### Common Issues

1. **No Dart files found**: Ensure you're in a Flutter project directory
2. **Permission errors**: Check file permissions and try running with appropriate privileges
3. **Backup creation fails**: Ensure you have write permissions in the project directory
4. **API key not found**: Use `transflow set-api-key -k your-key` to save your API key
5. **Translation API errors**: Check your API key and network connection

### Getting Help

```bash
# Show help
transflow-cli --help

# Show help for specific command
transflow-cli extract --help
transflow-cli translate --help
transflow-cli set-api-key --help

# Show version
transflow-cli version
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](https://github.com/transflow/transflow-cli/blob/main/CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/transflow/transflow-cli/blob/main/LICENSE) file for details.

## 🔗 Links

- **Documentation**: [https://github.com/transflow/transflow-cli/wiki](https://github.com/transflow/transflow-cli/wiki)
- **Issues & Support**: [https://github.com/transflow/transflow-cli/issues](https://github.com/transflow/transflow-cli/issues)
- **GitHub Repository**: [https://github.com/transflow/transflow-cli](https://github.com/transflow/transflow-cli)

## 📊 Version History

- **v0.1.0**: Initial release with basic text extraction and translation file generation
- **v0.1.1**: Added API key storage and management with `set-api-key` command

---

Made with ❤️ by the TransFlow Team
