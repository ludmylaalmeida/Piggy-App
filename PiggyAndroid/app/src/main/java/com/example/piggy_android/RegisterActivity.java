package com.example.piggy_android;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Patterns;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.HashMap;
import java.util.Set;

public class RegisterActivity extends AppCompatActivity {

    EditText emailTextField, passwordTextField;
    Button proceedBtn;
    TextView haveAccountTextView;

    // progress bar
    ProgressDialog progressDialog;

    private FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        // Actionbar
        ActionBar actionBar = getSupportActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
        actionBar.setDisplayShowHomeEnabled(true);

        // init
        emailTextField = findViewById(R.id.registerEmail);
        passwordTextField = findViewById(R.id.registerPassword);
        proceedBtn = findViewById(R.id.proceedBtn);
        haveAccountTextView = findViewById(R.id.haveAccountLink);

        mAuth = FirebaseAuth.getInstance();

        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Registering User...");


        // handle registration
        proceedBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                progressBar.
                // input email, password
                String email = emailTextField.getText().toString().trim();
                String password = passwordTextField.getText().toString().trim();

                // validate
                if (!Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
                    // set error and focus to email edit
                    emailTextField.setError("Invalid Email");
                    emailTextField.setFocusable(true);
                } else if( password.length() < 6) {
                    passwordTextField.setError("Password length must be at least 6 characters");
                    passwordTextField.setFocusable(true);
                } else {
                    registerUser(email, password);
                }

            }
        });

        // handle user that has account
        haveAccountTextView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(RegisterActivity.this, LoginActivity.class));
            }
        });

    }

    private void registerUser(String email, String password) {

        progressDialog.show();

        mAuth.createUserWithEmailAndPassword(email, password)
                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {
                            progressDialog.dismiss();
                            // Sign in success, update UI with the signed-in user's information
                            FirebaseUser user = mAuth.getCurrentUser();
                            // get user info
                            String email = user.getEmail();
                            String uid = user.getUid();
                            // Store user information at realtime database
                            HashMap<String, Object> hashMap = new HashMap<>();
                            // put info into hashmap
                            hashMap.put("email", email);
                            hashMap.put("uid", uid);
                            hashMap.put("firstName", "");
                            hashMap.put("lastName", "");
                            hashMap.put("dateOfBirth", "");
                            hashMap.put("profileImage", "");
                            hashMap.put("gender", "");
                            hashMap.put("city", "");

                            FirebaseDatabase database = FirebaseDatabase.getInstance();
                            // path to store user data
                            DatabaseReference reference = database.getReference("Users");
                            // put data within hashmap in database
                            reference.child(uid).setValue(hashMap);

                            Toast.makeText(RegisterActivity.this, "Account created", Toast.LENGTH_SHORT).show();
                            startActivity(new Intent(RegisterActivity.this, SetUpProfileActivity.class));
                        } else {
                            progressDialog.dismiss();
                            // If sign in fails, display a message to the user.
                            Toast.makeText(RegisterActivity.this, "Authentication failed.",
                                    Toast.LENGTH_SHORT).show();
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {
                progressDialog.dismiss();
                Toast.makeText(RegisterActivity.this, " " + e.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed(); // go to previous activity
        return super.onSupportNavigateUp();
    }
}