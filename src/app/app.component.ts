import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../environments/environment';

@Component({
  selector: 'app-root',
  template: `
    <div style="font-family:sans-serif; padding:2rem;">
      <h1>{{ greeting }}</h1>
    </div>
  `
})
export class AppComponent implements OnInit {
  greeting = 'Loading…';

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http
      .get<{ name: string }>(`${environment.apiUrl}/getname`)
      .subscribe(
        res  => (this.greeting = `Hello ${res.name}`),
        _err => (this.greeting = 'Backend unreachable')
      );
  }
}
