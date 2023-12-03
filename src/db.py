from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Movie(db.Model):
    """
    Movie Model
    """
    __tablename__ = "movie"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    length = db.Column(db.Integer, nullable=False)
    genre = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=False)
    reviews = db.relationship("Review", cascade="delete")

    def __init__(self, **kwargs):
        """
        Initialize a Movie object
        """
        self.name = kwargs.get("name", "")
        self.length = kwargs.get("length")
        self.genre = kwargs.get("genre", "")
        self.description = kwargs.get("description", "")

    def serialize(self):
        """
        Serialize a Movie object
        """
        return {
            "id": self.id,
            "name": self.name,
            "length": self.length,
            "genre": self.genre,
            "description": self.description,
            "reviews": [r.serialize() for r in self.reviews]
        }

    def get_reviews(self):
        """
        Returns a dictionary for the movie as a list
        """
        return [r.serialize() for r in self.reviews]

    def simple_serialize(self):
        """
        Serialize a Movie object
        fields
        """
        return {}


class Review(db.Model):
    """
    Review Model
    """
    __tablename__ = "review"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    title = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=False)
    stars = db.Column(db.Integer, nullable=False)
    likes = db.Column(db.Integer, nullable=False)
    movie_id = db.Column(db.Integer, db.ForeignKey(
        "movie.id"), nullable=False)

    def __init__(self, **kwargs):
        """
        Initialize a Assignment object
        """
        self.name = kwargs.get("name", "")
        self.title = kwargs.get("title", "")
        self.description = kwargs.get("description", "")
        self.stars = kwargs.get("stars", "")
        self.likes = kwargs.get("likes", "")
        self.movie_id = kwargs.get("movie_id")

    def increment_likes(self):
        """
        Increments the likes on a review by 1
        """
        self.likes = self.likes + 1

    def decrement_likes(self):
        """
        Decrements the likes on a review by 1
        """
        if self.likes > 0:
            self.likes = self.likes - 1

    def serialize(self):
        """
        Serialize a Review object
        """
        return {
            "id": self.id,
            "name": self.name,
            "title": self.title,
            "description": self.description,
            "stars": self.stars,
            "likes": self.likes,
        }
