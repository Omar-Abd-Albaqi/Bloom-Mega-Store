import 'package:bloom/providers/profile_providers/addresses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AddressNoteField extends StatefulWidget {
  const AddressNoteField({super.key});

  @override
  State<AddressNoteField> createState() => _AddressNoteFieldState();
}

class _AddressNoteFieldState extends State<AddressNoteField> {
  final TextEditingController _controller = TextEditingController();
  static const int _maxChars = 300;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {}); // Updates character counter
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int currentLength = _controller.text.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Note (optional) - $currentLength/$_maxChars characters",
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: _controller,
          maxLength: _maxChars,
          maxLines: null,
          minLines: 4,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: "Add a note about this address",
            border: OutlineInputBorder(),
            counterText: "", // Hide default counter at the bottom
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validator: (value) {
            if (value != null && value.length > _maxChars) {
              return "Note cannot exceed $_maxChars characters";
            }
            return null;
          },
          onSaved: (value) {
            context.read<AddressesProvider>().note = value ?? "";
          },
        ),
      ],
    );
  }
}
