# What If ?

<p align="center">
    <img src="screenshots/preview.png" width="100%"/>
</p>

"What If?" is an application that uses AI to create images from text.

## Features

- ***Generate Image from Text:*** Transform your text input into a visually appealing image, making it more engaging and shareable across various platforms.

- ***Post Generated Image:*** Easily share your generated image with others by posting it within the application, allowing users to view and interact with your content.

- ***Follow Other Users:*** Stay connected with other users by following their profiles, ensuring you never miss out on their latest posts and updates.

- ***Like Others' Posts:*** Show your appreciation for other users' content by liking their posts, fostering a positive and supportive community within the application.

## Technologies Used

- [Flutter](https://flutter.dev) used for building the frontend of the application.
- [Supabase](https://supabase.com) used for backend and storage.
- [Monsterapi](https://monsterapi.ai)  used to generate images for the application.
- [Aptabase](https://aptabase.com/) used for analytics.

## Develop

To set up and run the Flutter project locally, follow these steps:

1. Clone the project repository using Git:

   ```bash
   git clone git@github.com:mohammadhprp/what-if.git
   ```

2. Navigate to the project directory:

    ```bash
    cd what-if
    ```

3. Install the project dependencies by running the following command:

    ```bash
    flutter pub get
    ```

4. Locate the .env.example file in the project's root directory and make a copy of it named .env.

5. Open the .env file and provide the necessary values for the following environment variables:

    - ***Get SUPABASE_URL and SUPABASE_ANON_KEY***: Sign in to your Supabase account at [supabase.com](https://supabase.com), and navigate to the API settings of your project. Copy the `SUPABASE_URL` and `SUPABASE_ANON_KEY` values and add them to your .env file

    - ***Get MASTER_API_BEARER_TOKEN and MASTER_API_X_API_KEY***: Sign up for an account at [monsterapi.ai](https://monsterapi.ai), and obtain the `MASTER_API_BEARER_TOKEN` and `MASTER_API_X_API_KEY` values. Add these values to your .env file.

    - ***Get APTABASE_KEY***: Sign up for an account at [aptabase.com](https://aptabase.com), and obtain the `APTABASE_KEY` value. Add these value to your .env file

6. Save the changes to the .env file.

7. Run the Flutter project using the following command:

    ```bash
    flutter run
    ```

This command will launch the project on your connected device or emulator.

## Contributing

1. Fork the repository.
2. Create a new branch for your feature.
3. Make your changes and commit them with clear commit messages.
4. Submit a pull request to the `master` branch.

## License

This project is licensed under the MIT [License](License) - see the LICENSE file for details.
