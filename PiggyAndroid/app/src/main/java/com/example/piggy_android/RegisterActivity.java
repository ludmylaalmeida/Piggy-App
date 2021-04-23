package com.example.piggy_android;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Patterns;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class RegisterActivity extends AppCompatActivity {

    EditText emailTextField, passwordTextField;
    Button proceedBtn;

    // progress bar
//    ProgressDialog progressDialog;

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

        mAuth = FirebaseAuth.getInstance();

//        progressDialog = new ProgressDialog(this);
//        progressDialog.setMessage("Registering User...");


        // handle registration
        proceedBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
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

    }

    private void registerUser(String email, String password) {

//        progressDialog.show();

        mAuth.createUserWithEmailAndPassword(email, password)
                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) {
//                            progressDialog.dismiss();
                            // Sign in success, update UI with the signed-in user's information
                            FirebaseUser user = mAuth.getCurrentUser();
                            Toast.makeText(RegisterActivity.this, "Account created", Toast.LENGTH_SHORT).show();
                            startActivity(new Intent(RegisterActivity.this, ProfileActivity.class));
                        } else {
//                            progressDialog.dismiss();
                            // If sign in fails, display a message to the user.
                            Toast.makeText(RegisterActivity.this, "Authentication failed.",
                                    Toast.LENGTH_SHORT).show();
                        }
                    }
                }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {
//                progressDialog.dismiss();
                Toast.makeText(RegisterActivity.this, " " + e.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
    }
}