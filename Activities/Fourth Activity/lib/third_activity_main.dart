import 'package:flutter/material.dart';

void main() {
  runApp(const ThirdActivityApp());
}

class ThirdActivityApp extends StatelessWidget {
  const ThirdActivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Third Activity – Forms & Input Handling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ThirdActivityHome(),
    );
  }
}

class ThirdActivityHome extends StatelessWidget {
  const ThirdActivityHome({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = <_DemoTile>[
      _DemoTile('1. Username Form', (ctx) => const UsernameFormScreen()),
      _DemoTile('2–4. Login Form with Validation', (ctx) => const LoginFormScreen()),
      _DemoTile('5. Mixed Inputs (Text, Checkbox, Switch)', (ctx) => const MixedInputsFormScreen()),
      _DemoTile('6. Registration Form', (ctx) => const RegistrationFormScreen()),
      _DemoTile('7. Role Dropdown', (ctx) => const RoleDropdownFormScreen()),
      _DemoTile('8. Date & Time Picker', (ctx) => const DateTimePickerFormScreen()),
      _DemoTile('9. Controller Display', (ctx) => const ControllerDisplayScreen()),
      _DemoTile('10. Save to Local List', (ctx) => const LocalListFormScreen()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Third Activity – Forms')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final tile = tiles[index];
          return ListTile(
            title: Text(tile.title),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: tile.builder),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: tiles.length,
      ),
    );
  }
}

class _DemoTile {
  final String title;
  final WidgetBuilder builder;
  const _DemoTile(this.title, this.builder);
}

// 1. Simple form with TextFormField for entering a username.
class UsernameFormScreen extends StatefulWidget {
  const UsernameFormScreen({super.key});
  @override
  State<UsernameFormScreen> createState() => _UsernameFormScreenState();
}

class _UsernameFormScreenState extends State<UsernameFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  String? _submitted;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Username Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a username'
                    : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _submitted = _usernameController.text);
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 12),
              if (_submitted != null)
                Text('Submitted username: $_submitted'),
            ],
          ),
        ),
      ),
    );
  }
}

// 2–4. Login form with email/password, validation, and GlobalKey<FormState>.
class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});
  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _status;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email is required';
                  if (!value.contains('@')) return 'Email must contain @';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Password is required';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _status =
                        'Login submitted: ${_emailController.text} / ${'*' * _passwordController.text.length}');
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 12),
              if (_status != null) Text(_status!),
            ],
          ),
        ),
      ),
    );
  }
}

// 5. Form with TextField, Checkbox, and Switch.
class MixedInputsFormScreen extends StatefulWidget {
  const MixedInputsFormScreen({super.key});
  @override
  State<MixedInputsFormScreen> createState() => _MixedInputsFormScreenState();
}

class _MixedInputsFormScreenState extends State<MixedInputsFormScreen> {
  final _textController = TextEditingController();
  bool _isChecked = false;
  bool _isSwitched = false;
  String? _result;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mixed Inputs')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Text'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (v) => setState(() => _isChecked = v ?? false),
                ),
                const Text('Checkbox')
              ],
            ),
            Row(
              children: [
                Switch(
                  value: _isSwitched,
                  onChanged: (v) => setState(() => _isSwitched = v),
                ),
                const Text('Switch')
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() => _result =
                    'Text: ${_textController.text}, Checked: $_isChecked, Switched: $_isSwitched');
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 12),
            if (_result != null) Text(_result!),
          ],
        ),
      ),
    );
  }
}

// 6. Registration form with name, email, password, confirm password.
class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});
  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _status;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Name is required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email is required';
                    if (!v.contains('@')) return 'Email must contain @';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (v) => (v == null || v.isEmpty) ? 'Password is required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmController,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Confirm your password';
                    if (v != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _status = 'Registered ${_nameController.text}');
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 12),
                if (_status != null) Text(_status!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 7. Dropdown menu inside a form to select a user's role.
class RoleDropdownFormScreen extends StatefulWidget {
  const RoleDropdownFormScreen({super.key});
  @override
  State<RoleDropdownFormScreen> createState() => _RoleDropdownFormScreenState();
}

class _RoleDropdownFormScreenState extends State<RoleDropdownFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _role;
  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Role Dropdown')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Role'),
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'User', child: Text('User')),
                ],
                onChanged: (v) => setState(() => _role = v),
                validator: (v) => v == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _status = 'Selected role: $_role');
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 12),
              if (_status != null) Text(_status!),
            ],
          ),
        ),
      ),
    );
  }
}

// 8. Date picker and time picker input inside a form.
class DateTimePickerFormScreen extends StatefulWidget {
  const DateTimePickerFormScreen({super.key});
  @override
  State<DateTimePickerFormScreen> createState() => _DateTimePickerFormScreenState();
}

class _DateTimePickerFormScreenState extends State<DateTimePickerFormScreen> {
  DateTime? _date;
  TimeOfDay? _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date & Time Picker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(now.year - 5),
                        lastDate: DateTime(now.year + 5),
                        initialDate: _date ?? now,
                      );
                      if (!mounted) return;
                      setState(() => _date = picked);
                    },
                    child: Text(_date == null
                        ? 'Pick Date'
                        : 'Date: ${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: _time ?? TimeOfDay.now(),
                      );
                      if (!mounted) return;
                      setState(() => _time = picked);
                    },
                    child: Text(_time == null
                        ? 'Pick Time'
                        : 'Time: ${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Selected: ${_date == null ? '-' : _date!.toIso8601String().split('T').first} ${_time == null ? '-' : _time!.format(context)}',
            ),
          ],
        ),
      ),
    );
  }
}

// 9. Use a controller to capture and display text after pressing a button.
class ControllerDisplayScreen extends StatefulWidget {
  const ControllerDisplayScreen({super.key});
  @override
  State<ControllerDisplayScreen> createState() => _ControllerDisplayScreenState();
}

class _ControllerDisplayScreenState extends State<ControllerDisplayScreen> {
  final _controller = TextEditingController();
  String? _display;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller Display')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => setState(() => _display = _controller.text),
              child: const Text('Show'),
            ),
            const SizedBox(height: 12),
            if (_display != null) Text('You typed: $_display'),
          ],
        ),
      ),
    );
  }
}

// 10. Form that saves data into a local list and displays submitted inputs below.
class LocalListFormScreen extends StatefulWidget {
  const LocalListFormScreen({super.key});
  @override
  State<LocalListFormScreen> createState() => _LocalListFormScreenState();
}

class _LocalListFormScreenState extends State<LocalListFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();
  final List<String> _items = [];

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local List Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _itemController,
                      decoration: const InputDecoration(labelText: 'Item'),
                      validator: (v) => (v == null || v.isEmpty) ? 'Enter an item' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _items.add(_itemController.text);
                          _itemController.clear();
                        });
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Submitted Items:'),
            const SizedBox(height: 8),
            Expanded(
              child: _items.isEmpty
                  ? const Text('No items yet.')
                  : ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(_items[index]),
                      ),
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemCount: _items.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}