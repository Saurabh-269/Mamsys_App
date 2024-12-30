import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  int _currentStep = 0;

  // Define the chatbot flow
  final List<Map<String, dynamic>> _chatFlow = [
    {
      "question": "Hello! How can I assist you today?",
      "options": [
        "IT Staffing and Recruitment Services",
        "Web Development",
        "Mobile App Development",
        "Artificial Intelligence Solutions",
        "Digital Transformation",
        "Quality Assurance and Testing",
        "SAP Solutions",
        "Cloud Services",
        "Other"
      ],
      "followUp": {
        "Web Development": [
          {
            "question": "What specific web development service are you interested in?",
            "options": [
              "Website Design",
              "Web Application Development",
              "WordPress Development",
              "Website Maintenance and Support"
            ]
          },
          {
            "question": "What is your estimated budget for this project?",
            "options": [
              "Under \$500",
              "\$500–\$1000",
              "\$1000–\$5000",
              "Over \$5000"
            ]
          },
          {
            "question": "What is your preferred timeline for project completion?",
            "options": [
              "Less than 1 month",
              "1–2 months",
              "2–3 months",
              "More than 3 months"
            ]
          },
        ],
        "Artificial Intelligence Solutions": [
          {
            "question": "What specific AI solution are you looking for?",
            "options": [
              "AI-Powered Digital Transformation",
              "AI on SAP BTP",
              "Generative AI Solutions",
              "AI Consulting"
            ]
          },
          {
            "question": "What is the primary goal of your AI initiative?",
            "options": [
              "Automating processes",
              "Enhancing customer experiences",
              "Data and analytics improvement",
              "Other"
            ]
          },
          {
            "question": "What is your preferred implementation timeline?",
            "options": [
              "Less than 3 months",
              "3–6 months",
              "6–12 months",
              "More than a year"
            ]
          },
        ],
        "SAP Solutions": [
          {
            "question": "Which SAP solution do you require assistance with?",
            "options": [
              "SAP Integration Suite",
              "SAP BTP Solutions",
              "Application Development Automation on SAP BTP",
              "Legacy Cloud Migration to SAP"
            ]
          },
          {
            "question": "What is your organization’s current SAP setup?",
            "options": [
              "SAP implemented, but needs enhancement",
              "No SAP, starting from scratch",
              "Exploring SAP options",
              "Other"
            ]
          },
        ]
      }
    },
    {
      "question": "Would you like to schedule a consultation with our experts?",
      "options": ["Yes", "No"]
    },
    {
      "question": "Would you like to receive a detailed proposal for your selected service?",
      "options": ["Yes", "No"]
    },
    {
      "question": "How did you hear about us?",
      "options": [
        "Online Search",
        "Social Media",
        "Referral",
        "Advertisement"
      ]
    }
  ];

  final List<String> _selectedOptions = [];
  List<Map<String, dynamic>> _followUpQuestions = [];

  void _selectOption(String option) {
    setState(() {
      _selectedOptions.add(option);

      // Handle follow-up questions
      if (_currentStep == 0 && _chatFlow[_currentStep]["followUp"] != null) {
        if (_chatFlow[_currentStep]["followUp"][option] != null) {
          _followUpQuestions = _chatFlow[_currentStep]["followUp"][option];
        }
      }

      // If follow-up questions are present, proceed to them
      if (_followUpQuestions.isNotEmpty) {
        _chatFlow.insertAll(_currentStep + 1, _followUpQuestions);
        _followUpQuestions = [];
      }

      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mamsys Chatbot"),
        backgroundColor: Colors.deepPurple,
      ),
      body: _currentStep < _chatFlow.length
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _chatFlow[_currentStep]["question"],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ..._chatFlow[_currentStep]["options"]
                      .map<Widget>((option) {
                    return ElevatedButton(
                      onPressed: () => _selectOption(option),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      child: Text(option),
                    );
                  }).toList(),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Thank you for interacting with us!",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentStep = 0;
                        _selectedOptions.clear();
                      });
                    },
                    child: const Text("Restart"),
                  ),
                ],
              ),
            ),
    );
  }
}
