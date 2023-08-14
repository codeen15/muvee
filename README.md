# Muvee - Movie Watchlist App

Muvee is a mobile application built using Flutter for the frontend and Django for the backend. It allows users to create and manage their movie watchlists effortlessly.

Muvee App Screenshot
![alt text](https://github.com/codeen15/muvee/blob/main/snapshots/1.png?raw=true)
![alt text](https://github.com/codeen15/muvee/blob/main/snapshots/2.png?raw=true)
![alt text](https://github.com/codeen15/muvee/blob/main/snapshots/3.png?raw=true)
![alt text](https://github.com/codeen15/muvee/blob/main/snapshots/4.png?raw=true)
![alt text](https://github.com/codeen15/muvee/blob/main/snapshots/5.png?raw=true)



## Features

- **Add Movies:** Easily add movies to your watchlist with just a few taps.
- **Search Movies:** Search for movies using titles, genres, or keywords.
- **Mark Watched:** Keep track of which movies you've watched and which ones are pending.
- **Personalization:** Customize your watchlist by categorizing movies into genres, favorites, etc.
- **Backend Integration:** Utilizes Django backend for secure and efficient data storage and retrieval.

## Technologies Used

- **Frontend:** Flutter
- **Backend:** Django
- **Database:** sqlite3
- **Authentication:** Knox bearer token
- **API Documentation:** TVMaze API - https://www.tvmaze.com/api

## Getting Started

### Prerequisites

- Flutter installed (version 3.10.4 or higher)
- Django installed (version 4.2.2 or higher)
- DB Browser (optional - browsing sqlite3 db)

### Installation

1. Clone this repository: `git clone https://github.com/codeen15/muvee.git`
2. Navigate to the frontend directory: `cd muvee/muvee_mobile`
3. Install Flutter dependencies: `flutter pub get`
4. Navigate to the backend directory: `cd ../backend`
5. Install Django dependencies: `pip install -r requirements.txt`

### Configuration

- Configure frontend settings in `muvee/muvee_mobile/lib/config.dart`.
- Configure backend settings in `muvee/backend/muvee/settings.py`.

### Usage

1. Run the backend server: `python manage.py runserver`
2. Run the Flutter app: `flutter run`
3. Make sure backend server is matched with hosts.dart file in lib/config/ folder


## Contributing

Contributions are welcome! Here's how you can get involved:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-new-feature`
3. Make your changes and commit them: `git commit -m "Add some feature"`
4. Push the changes to your fork: `git push origin feature-new-feature`
5. Submit a pull request detailing your changes.

## Contact

For any inquiries or feedback, please reach out to mnuraddin2000@gmail.com.
