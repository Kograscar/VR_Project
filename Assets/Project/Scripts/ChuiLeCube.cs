using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChuiLeCube : MonoBehaviour {

    [SerializeField] List<GameObject> _faces;

    Rigidbody _rig;

    private void OnEnable()
    {
        _rig = GetComponent<Rigidbody>();
    }

    private void Update()
    {
        foreach (var item in _faces)
        {
            RaycastHit hit = new RaycastHit();
            List<GameObject> touchedItem = new List<GameObject>();

            if(Physics.Raycast(item.transform.position + new Vector3(item.transform.lossyScale.x / 2, item.transform.lossyScale.x / 2, 0), item.transform.forward, out hit, 0.1f))
            {
                touchedItem.Add(hit.collider.gameObject);
            }

            if (Physics.Raycast(item.transform.position + new Vector3(-item.transform.lossyScale.x / 2, item.transform.lossyScale.x / 2, 0), item.transform.forward, out hit, 0.1f))
            {
                touchedItem.Add(hit.collider.gameObject);
            }

            if (Physics.Raycast(item.transform.position + new Vector3(item.transform.lossyScale.x / 2, -item.transform.lossyScale.x / 2, 0), item.transform.forward, out hit, 0.1f))
            {
                touchedItem.Add(hit.collider.gameObject);
            }

            if (Physics.Raycast(item.transform.position + new Vector3(-item.transform.lossyScale.x / 2, -item.transform.lossyScale.x / 2, 0), item.transform.forward, out hit, 0.1f))
            {
                touchedItem.Add(hit.collider.gameObject);
            }

            int goodtouch = new int();

            if(touchedItem.Count == 4)
            {

            }
        }
    }
}
