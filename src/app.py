import json
from db import db
from flask import Flask, request
from db import Movie
from db import Review

app = Flask(__name__)
db_filename = "database.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


def sucess_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code


@app.route("/api/movies/")
def get_movies():
    """
    Endpoint to get all movies
    """
    movies = [movie.serialize() for movie in Movie.query.all()]
    return sucess_response({"movies": movies})


@app.route("/api/movies/", methods=["POST"])
def create_movie():
    """
    Endpoint to create a movie
    """
    body = json.loads(request.data)
    name = body.get("name")
    length = body.get("length")
    genre = body.get("genre")
    description = body.get("description")
    if name is None or length is None or genre is None or description is None:
        return failure_response("Enter valid movie information!", 400)
    new_movie = Movie(
        name=name,
        length=length,
        genre=genre,
        description=description
    )
    db.session.add(new_movie)
    db.session.commit()
    return sucess_response(new_movie.serialize(), 201)


@app.route("/api/movies/<int:movie_id>/")
def get_movie(movie_id):
    """
    Endpoint for getting a specific movie
    """
    movie = Movie.query.filter_by(id=movie_id).first()
    if movie is None:
        return failure_response("Movie not found!")
    return sucess_response(movie.serialize())


@app.route("/api/movies/<int:movie_id>/", methods=["DELETE"])
def delete_movie(movie_id):
    """
    Endpoint for deleting a specific movie
    """
    movie = Movie.query.filter_by(id=movie_id).first()
    if movie is None:
        return failure_response("Movie not found!")
    db.session.delete(movie)
    db.session.commit()
    return sucess_response(movie.serialize())


@app.route("/api/review/<int:movie_id>/", methods=["POST"])
def create_review(movie_id):
    """
    Endpoint for creating a review
    """
    movie = Movie.query.filter_by(id=movie_id).first()
    if movie is None:
        return failure_response("Movie not found!")
    body = json.loads(request.data)
    name = body.get("name")
    title = body.get("title")
    description = body.get("description")
    stars = body.get("stars")
    if title is None or description is None or stars is None or movie_id is None:
        return failure_response("Enter valid information!", 400)
    new_review = Review(
        name=name,
        title=title,
        description=description,
        stars=stars,
        likes=0,
        movie_id=movie_id
    )
    db.session.add(new_review)
    movie.reviews.append(new_review)
    db.session.commit()
    return sucess_response(new_review.serialize(), 201)


@app.route("/api/review/like/<int:review_id>/", methods=["POST"])
def like_review(review_id):
    """
    Endpoint for liking a review
    """
    review = Review.query.filter_by(id=review_id).first()
    if review is None:
        return failure_response("Review not found!")
    review.increment_likes()
    db.session.commit()
    return sucess_response(review.serialize(), 201)


@app.route("/api/review/unlike/<int:review_id>/", methods=["POST"])
def unlike_review(review_id):
    """
    Endpoint for unliking a review
    """
    review = Review.query.filter_by(id=review_id).first()
    if review is None:
        return failure_response("Review not found!")
    review.decrement_likes()
    db.session.commit()
    return sucess_response(review.serialize(), 201)


@app.route("/api/review/<int:review_id>/", methods=["DELETE"])
def delete_review(review_id):
    """
    Endpoint for deleting a specific review
    """
    review = Review.query.filter_by(id=review_id).first()
    if review is None:
        return failure_response("Review not found!")
    db.session.delete(review)
    db.session.commit()
    return sucess_response(review.serialize())

# def delete_review_broken(review_id):
    """
    Endpoint for deleting a specific review
    """
    review = Movie.query.filter_by(id=review_id).first()
    if review is None:
        return failure_response("Review not found!")
    db.session.delete(review)
    db.session.commit()
    return sucess_response(review.serialize())


@app.route("/api/reviews/<int:movie_id>/")
def get_reviews_of_movie(movie_id):
    """
    Endpoint for getting all reviews of a specific movie
    """
    movie = Movie.query.filter_by(id=movie_id).first()
    if movie is None:
        return failure_response("Movie not found!")
    return sucess_response({"reviews": movie.get_reviews()})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
