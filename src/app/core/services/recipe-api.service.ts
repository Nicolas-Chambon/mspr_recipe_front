import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { Recipe } from '../../models/models';
import { catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root',
})
export class RecipeApiService {
  apiUrl = 'https://api-recipe.nonstopintegration.ml';

  private static handleError(error: HttpErrorResponse): Observable<any> {
    let errorMessage;
    if (error.error instanceof ErrorEvent) {
      // Client-side errors
      errorMessage = { error: error.error.message };
    } else {
      // Server-side errors
      errorMessage = { error: error.message };
    }
    return of(errorMessage);
  }

  constructor(private http: HttpClient) {}

  list(): Observable<any> {
    return this.http.get(`${this.apiUrl}/api/recipes/`).pipe(catchError(RecipeApiService.handleError));
  }

  /*  download(): Observable<any> {

  }*/
}
