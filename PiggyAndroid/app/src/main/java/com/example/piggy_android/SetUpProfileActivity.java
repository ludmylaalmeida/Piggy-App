package com.example.piggy_android;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.storage.FirebaseStorage;

import java.util.HashMap;

public class SetUpProfileActivity extends AppCompatActivity {

    EditText firstNameEditText, lastNameEditText, usernameEditText, dateOfBirthEditText, cityEditText;
    AutoCompleteTextView genderTextView;
    Button saveBtn;

    ProgressDialog progressDialog;

    FirebaseAuth firebaseAuth;
    FirebaseUser user;
    FirebaseDatabase firebaseDatabase;
    DatabaseReference databaseReference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_set_up_profile);

        firebaseAuth = FirebaseAuth.getInstance();
        user = firebaseAuth.getCurrentUser();
        firebaseDatabase = FirebaseDatabase.getInstance();
        databaseReference = firebaseDatabase.getReference("Users");

        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Registering User...");

        firstNameEditText = findViewById(R.id.registerFirstName);
        lastNameEditText = findViewById(R.id.registerLastName);
        usernameEditText = findViewById(R.id.registerUsername);
        dateOfBirthEditText = findViewById(R.id.registerBirthday);
        genderTextView = (AutoCompleteTextView) findViewById(R.id.registerGender);
        cityEditText = findViewById(R.id.registerCity);
        saveBtn = findViewById(R.id.saveBtn);

        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                android.R.layout.select_dialog_item, GENDER_OPTIONS);

        genderTextView.setAdapter(adapter);

        saveBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setUpProfile(firstNameEditText, lastNameEditText, usernameEditText, dateOfBirthEditText, genderTextView, cityEditText);
                startActivity(new Intent(SetUpProfileActivity.this, DashboardActivity.class));
            }
        });
    }

    private static final String[] GENDER_OPTIONS = new String[] {
        "Female", "Male", "Gender Fluid", "Other"
    };

    private void setUpProfile(EditText firstNameEditText, EditText lastNameEditText, EditText usernameEditText, EditText dateOfBirthEditText, AutoCompleteTextView genderTextView, EditText cityEditText) {

        // get the info
        String firstName = firstNameEditText.getText().toString().trim();
        String lastName = lastNameEditText.getText().toString().trim();
        String username = usernameEditText.getText().toString().trim();
        String dateOfBirth = dateOfBirthEditText.getText().toString().trim();
        String gender = genderTextView.getText().toString().trim();
        String city = cityEditText.getText().toString().trim();

        // Store user information at realtime database
        HashMap<String, Object > hashMap = new HashMap<>();
        // put info into hashmap
        hashMap.put("firstName", firstName);
        hashMap.put("lastName", lastName);
        hashMap.put("uid", username);
        hashMap.put("dateOfBirth", dateOfBirth);
        hashMap.put("gender", gender);
        hashMap.put("city", city);

        if (!TextUtils.isEmpty(firstName) && !TextUtils.isEmpty(lastName) && !TextUtils.isEmpty(username) && !TextUtils.isEmpty(dateOfBirth) && !TextUtils.isEmpty(gender)  ) {
            databaseReference.child(user.getUid()).updateChildren(hashMap)
                    .addOnSuccessListener(new OnSuccessListener<Void>() {
                        @Override
                        public void onSuccess(Void aVoid) {
//                            progressDialog.dismiss();
                            Toast.makeText(SetUpProfileActivity.this, "User information Saved...", Toast.LENGTH_SHORT).show();
                        }
                    }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
//                progressDialog.dismiss();
                    Toast.makeText(SetUpProfileActivity.this, "Something went wrong, try again" + e.getMessage(), Toast.LENGTH_SHORT).show();

                }
            });
        }

    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed(); // go to previous activity
        return super.onSupportNavigateUp();
    }
}