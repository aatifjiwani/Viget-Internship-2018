<h1 align="center">Hacker News Clone (<a href="https://haxxornews-vgt.herokuapp.com">Haxxor News</a>)</h1>
<p align="center">An introductory project using Ruby on Rails during my Viget Internship</p>
<p align="center" style='font-size: 10px;'>
  Current dashboard of Haxxor News:
<img src='https://storage.googleapis.com/haxxornews-img-container/Screen%20Shot%202018-07-06%20at%201.36.33%20PM.png' width='75%' height='auto'/>
</p>

<br>
<h3>What I was trying to recreate</h3>
<p align="center" style='font-size: 10px;'>
  Current dashboard of the real <a href="https://news.ycombinator.com">Hacker News</a>:
<img src='https://storage.googleapis.com/haxxornews-img-container/Screen%20Shot%202018-07-06%20at%201.33.44%20PM.png' width='75%' height='auto'/>
</p>

<br>

### Required features I've implemented
- User can create a profile natively with a unique username and email
- User can create and show an article that can be viewed on the dashboard

### Other features I've been able to implement
- Upload images alongside your profile or article <strong>(using ActiveStorage and GCS)</strong>
- Login or create an account with Facebook and LinkedIn <strong>(using OAuth and external gems)</strong>
- Ability to comment on a base article or comment on another comment <strong>(using polymorphism)</strong>
- Ability to up/down vote an article and comment <strong>(using polymorphism and AJAX)</strong>
- Ability to include your location with an article or your profile <strong>(using RESTful APIs)</strong>
- Filter articles on the dashboard based on recency or how highly rated the articles may be <strong>(using model scopes)</strong>
- Ability to reset a lost password with session expiring in 6 hours <strong>(using ActionMailer)</strong>

### Sample screenshots of Haxxor News

<h5 align="center">User profile:</h5>
<p align="center">
  <img src='https://storage.googleapis.com/haxxornews-img-container/Screen%20Shot%202018-07-06%20at%201.37.29%20PM.png' width='75%' height='auto'/>
</p>
<br>
<h5 align="center">Single article view:</h5>
<p align="center">
  <img src='https://storage.googleapis.com/haxxornews-img-container/Screen%20Shot%202018-07-06%20at%201.37.49%20PM.png' width='75%' height='auto'/>
</p>
<br>
<h5 align="center">Sign in view:</h5>
<p align="center">
  <img src='https://storage.googleapis.com/haxxornews-img-container/Screen%20Shot%202018-07-06%20at%202.51.42%20PM.png' width='75%' height='auto'/>
</p>
<br>
<h5 align="center">Create an account view:</h5>
<p align="center">
  <img src='https://storage.googleapis.com/haxxornews-img-container/Screen%20Shot%202018-07-06%20at%202.51.53%20PM.png' width='75%' height='auto'/>
</p>
