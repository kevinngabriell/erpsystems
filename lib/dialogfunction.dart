import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showWeightConverterDialog({
  required BuildContext context,
  required String selectedWeightUnit,
  required String selectedTargetWeightUnit,
  required TextEditingController txtWeightValue,
  required TextEditingController txtWeightResult,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Weight Converter',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
          ),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Row(
                children: [
                  // 1
                  SizedBox(
                    width: 100.w,
                    child: TextFormField(
                      readOnly: true,
                      initialValue: '1',
                      decoration: InputDecoration(
                        hintText: 'Insert weight',
                        // Update the prefixIcon DropdownButtonFormField items
                        prefixIcon: SizedBox(
                          width: 25.w,
                          child: DropdownButtonFormField<String>(
                            value: selectedWeightUnit,
                            onChanged: (newValue) {
                              // Handle onChanged for weight unit
                              // You might want to pass a callback for this
                              // or handle it within the parent widget
                            },
                            // Update the items for weight units
                            items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  // 2
                  SizedBox(
                    width: 100.w,
                    child: TextFormField(
                      controller: txtWeightValue,
                      onChanged: (value) {
                        // Handle onChanged for weight value
                        // You might want to pass a callback for this
                        // or handle it within the parent widget
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter weight',
                        // Update the prefixIcon DropdownButtonFormField items
                        prefixIcon: SizedBox(
                          width: 25.w,
                          child: DropdownButtonFormField<String>(
                            value: selectedWeightUnit,
                            onChanged: (newValue) {
                              // Handle onChanged for weight unit
                              // You might want to pass a callback for this
                              // or handle it within the parent widget
                            },
                            // Update the items for weight units
                            items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              const Divider(),
              SizedBox(height: 15.h),
              Row(
                children: [
                  // 3
                  SizedBox(
                    width: 100.w,
                    child: TextFormField(
                      controller: txtWeightResult,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Converted weight',
                        // Update the prefixIcon DropdownButtonFormField items
                        prefixIcon: SizedBox(
                          width: 25.w,
                          child: DropdownButtonFormField<String>(
                            value: selectedTargetWeightUnit,
                            onChanged: (newValue) {
                              // Handle onChanged for target weight unit
                              // You might want to pass a callback for this
                              // or handle it within the parent widget
                            },
                            // Update the items for target weight units
                            items: ['Kilograms', 'Grams', 'Liters'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
