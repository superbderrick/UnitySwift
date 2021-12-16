using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine.UI;
using UnityEngine;

#if UNITY_IOS || UNITY_TVOS
public class NativeAPI {
    [DllImport("__Internal")]
    public static extern void showHostMainWindow(string lastStringColor);
}
#endif

public class Cube : MonoBehaviour
{
    public Text text;
    void Update()
    {
        transform.Rotate(0, Time.deltaTime*10, 0);
    }
    
    

    string lastStringColor = "";
    public void ChangeColor()
    {
        if (GetComponent<Renderer>().material.color.Equals(Color.white))
        {
            GetComponent<Renderer>().material.color = Color.red;
            text.text = "BLUE";
        } else if (GetComponent<Renderer>().material.color.Equals(Color.red))
        {
            GetComponent<Renderer>().material.color = Color.blue;
            text.text = "WHITE";
        } else if (GetComponent<Renderer>().material.color.Equals(Color.blue))
        {
            GetComponent<Renderer>().material.color = Color.white;
            text.text = "RED";
        }  
        
    }


    void showHostMainWindow()
    {
        Debug.Log("showHostMainWindow");
    
            NativeAPI.showHostMainWindow(lastStringColor);
    
    }

    // void OnGUI()
    // {
    //     GUIStyle style = new GUIStyle("button");
    //     style.fontSize = 30;        
    //     if (GUI.Button(new Rect(400, 50, 200, 100), "Red", style)) ChangeColor("red");
    //     if (GUI.Button(new Rect(100, 50, 200, 100), "Blue", style)) ChangeColor("blue");
    //     
    //     if (GUI.Button(new Rect(10, 200, 400, 100), "Unload", style)) Application.Unload();
    //     if (GUI.Button(new Rect(440, 200, 400, 100), "Quit", style)) Application.Quit();
    // }
}

