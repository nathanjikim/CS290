import Foundation
import SwiftUI

class MovieStore: ObservableObject  {
  @Published var movies: [Movie] = Movie.sortedDummyData

  func createMovie(_ movie: Movie) {
    movies.append(movie)
  }

  func updateMovie(_ movie: Movie) {
    if let index = movies.firstIndex(where: { $0.id == movie.id }) {
      movies[index] = movie
    }
  }

  func deleteMovie(_ movie: Movie) {
    if let index = movies.firstIndex(where: { $0.id == movie.id }) {
      movies.remove(at: index)
    }
  }


  // Below Code saves movies to disk

  // Get the directory path
  private static func fileURL() throws -> URL {
    try FileManager.default.url(for: .documentDirectory,
                                   in: .userDomainMask,
                                   appropriateFor: nil,
                                   create: false)
      .appendingPathComponent("movies.data")
  }

  // start the async process to load.
  // withCheckedThrowingContinuation: Suspends the current task, then calls the given closure with a checked throwing continuation for the current task.
  static func load() async throws -> [Movie] {
    try await withCheckedThrowingContinuation { continuation in
      load { result in
        switch result {
        case .failure(let error):
          continuation.resume(throwing: error)
        case .success(let movies):
          continuation.resume(returning: movies)
        }
      }
    }
  }

  // Here's where we actually load from the file
  static func load(completion: @escaping (Result<[Movie], Error>)->Void) {
    DispatchQueue.global(qos: .background).async {
      do {
        let fileURL = try fileURL()
        guard let file = try? FileHandle(forReadingFrom: fileURL) else {
          DispatchQueue.main.async {
            completion(.success([]))
          }
          return
        }
        let movies = try JSONDecoder().decode([Movie].self, from: file.availableData)
        DispatchQueue.main.async {
          completion(.success(movies))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }

  // async save to file; same pattern as loading above
  @discardableResult
  static func save(movies: [Movie]) async throws -> Int {
    try await withCheckedThrowingContinuation { continuation in
      save(movies: movies) { result in
        switch result {
        case .failure(let error):
          continuation.resume(throwing: error)
        case .success(let moviesSaved):
          continuation.resume(returning: moviesSaved)
        }
      }
    }
  }

  static func save(movies: [Movie], completion: @escaping (Result<Int, Error>)->Void) {
    DispatchQueue.global(qos: .background).async {
      do {
        let data = try JSONEncoder().encode(movies)
        let outfile = try fileURL()
        try data.write(to: outfile)
        DispatchQueue.main.async {
          completion(.success(movies.count))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }

}
