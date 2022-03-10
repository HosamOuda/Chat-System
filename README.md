<h1> Chat Application 🗨📱 </h1>
<p align ="center"><img width="80%" height="20%" alt="Coding"  src="https://github.com/HosamOuda/Chat-System/blob/master/giphy.gif"></p>

<h2> Overall Description 💬 </h3>
<p> It's a chat system which allows the user to create a new application and create chats and messages within this application </p>

<h2> Features 🧾 </h2>
<li> Create an Application with a given name and implemented the rest of crud operation to create the application </li>
<li> Add chats to a target application </li>
<li> The ability to add messages to be associated to a certain chat </li>
<li> A postgresql Database that contains Models for ( Application , Chat , Message ) </li>
<li> Integration with elastic search </li>
 <hr>
<h2>User Manual 📓 </h2>

<h4> For Application </h4>
<ol>
  <li> The user can create an application and give it a <code> name </code>  </li>
  <li> To make update to the application <code> name </code> the user has to provide the <code> token </code> in the url   </li>
  <li> To make new chats the user also has to provide <code> token </code> in the calling url </li> 
</ol> 

<h4> For Chat </h4>
<ol>
  <li> The user can create a new chat by call the corresponding endpoint and pass to the application's <code> token </code> which belongs to it  </li>
  <li> To make any updates to the chat, the user should provide the chat's <code> id </code> to complete the transaction </li>
</ol> 

<h4> For Message </h4>
<p> To call the message APIs the user should provide either <code> application token </code> or <code> chat id  </code> in the calling url </p>
 
<hr>

<h4> All endpoint URLs are provided with examples in the <code> Instabug Chat Endpoints   </code>  postman collection so it's only required to download it and import it in the postman </h4>
