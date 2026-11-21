
## Step 1: Get Dependencies

Open the terminal in the Flutter project directory.

```bash
flutter pub get
```

## Step 2: Run All Tests

```bash
flutter test
```

## Step 3: Run Model Tests Only

```bash
flutter test test/model/
```

## Step 4: Run Service Tests Only

```bash
flutter test test/service/
```

## Step 5: Run One Specific Test File

```bash
flutter test test/service/meal_service_test.dart
```

## Expected Results

When all tests pass, Flutter displays successful test results in the terminal.

If a test fails, Flutter displays an error message that helps identify which test case needs to be fixed.

## Conclusion

Unit testing is important for ensuring the reliability of the Nutrition Tracking application.

Model tests verify the correctness of application data structures, while Service tests verify business operations and rules.

Testing both layers helps identify errors early and ensures that the application works correctly before integrating the user interface.
